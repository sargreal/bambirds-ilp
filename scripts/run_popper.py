#!/usr/bin/env python

import argparse
import os
import shutil
from multiprocessing import Process, Queue
from multiprocessing.queues import Empty
import sys
import signal
import time
import subprocess
import logging
import csv

scripts_dir = os.path.dirname(os.path.realpath(__file__))
root_dir = os.path.dirname(scripts_dir)
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s %(levelname)s %(name)s - %(message)s',
                    datefmt='%H:%M:%S',
                    # filename=os.path.join(root_dir, 'experiments.log'),
                    # filemode='a'
                    ),
logger = logging.getLogger("run_popper")

tmp_dir = os.path.join(root_dir, 'tmp', 'popper')
solution_dir = os.path.join(root_dir, 'solutions')


def copy_file_and_replace(src, dst, replacements):
    with open(src, 'r') as f:
        content = f.read()
        for k, v in replacements.items():
            content = content.replace(k, v)
        with open(dst, 'w') as f2:
            f2.write(content)


def run(args, result: Queue):
    process_logger = logging.getLogger('popper')
    if args.debug:
        process_logger.setLevel(logging.DEBUG)
    proc = None

    def shutdown():
        if proc:
            proc.kill()
            proc.wait()
            proc.stdout.close()

    def sigterm_handler(_signo, _stack_frame):
        shutdown()
        sys.exit(0)
    signal.signal(signal.SIGTERM, sigterm_handler)

    options = ['--timeout', str(args.timeout), tmp_dir]
    if args.bkcons:
        options.append('--bkcons')
    if args.datalog:
        options.append('--datalog')

    proc = subprocess.Popen(
        ['popper-ilp', *options], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    reading_hypothesis = False
    reading_solution = False
    current_hypothesis = []
    while proc.poll() is None:
        line = None
        try:
            line = proc.stdout.readline().decode('utf-8')
        except:
            break
        if not line:
            break

        if 'New best hypothesis' in line:
            reading_hypothesis = True
        elif "SOLUTION" in line:
            reading_solution = True
        elif reading_hypothesis:
            # Line looks like either:
            # 10:25:36 tp:4 fn:0 size:7
            # 10:25:36 f(A):- empty(A).
            # 10:25:36 f(A):- head(A,C),tail(A,B),even(C),f(B).
            # 10:25:36 ********************
            # The first line is the hypothesis stats, the following is the hypothesis itself. Lines start with a timestamp, so we can ignore that.
            # The last line is the end of the hypothesis and consists of stars.
            line = line[9:]
            if line.startswith('tp'):
                process_logger.info(line.strip())
            elif line.startswith('***'):
                reading_hypothesis = False
                result.put("".join(current_hypothesis))
                current_hypothesis = []
            else:
                process_logger.debug(line.strip())
                current_hypothesis.append(line)
        elif reading_solution:
            # Solution looks like:
            # ********** SOLUTION **********
            # Precision:1.00 Recall:1.00 TP:4 FN:0 TN:5 FP:0 Size:7
            # f(A):- empty(A).
            # f(A):- head(A,C),tail(A,B),even(C),f(B).
            # ******************************
            if line.startswith('Precision'):
                continue
            elif line.startswith('***'):
                reading_solution = False
                result.put("".join(current_hypothesis))
                current_hypothesis = []
                shutdown()
                break
            else:
                process_logger.debug(line.strip())
                current_hypothesis.append(line)
        elif args.debug:
            process_logger.debug(line.strip())
    result.put("Finished")


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--target', type=str,
                        choices=["supports", "stable", "dangerous"], default='supports')
    parser.add_argument('--dataset', type=str, default='all')
    parser.add_argument('--datalog', default=False, action='store_true',
                        help='use recall to order literals in rules')
    parser.add_argument('--bkcons', default=False, action='store_true',
                        help='deduce background constraints from Datalog background')
    parser.add_argument('--timeout', type=int, default=600,
                        help='timeout in seconds')
    parser.add_argument('--debug', default=False, action='store_true',
                        help='show debug messages')
    args = parser.parse_args()

    if args.debug:
        logger.setLevel(logging.DEBUG)

    padded_timeout = args.timeout + 10

    template_path = os.path.join(root_dir, 'popper', args.target)
    bias_file = os.path.join(template_path, 'bias.pl')
    bk_file = os.path.join(template_path, 'bk.pl')
    exs_file = os.path.join(template_path, 'exs.pl')

    logger.info('Running popper with the following arguments:')
    logger.info(args)

    # Copy bias directly to tmp folder
    os.makedirs(tmp_dir, exist_ok=True)
    bias_tmp_file = os.path.join(tmp_dir, 'bias.pl')
    shutil.copyfile(bias_file, bias_tmp_file)

    # Copy bk and exs to tmp folder, replacing <ROOT> with current_dir and <BACKGROUND> and <EXAMPLES> with the data paths
    bk_tmp_file = os.path.join(tmp_dir, 'bk.pl')
    exs_tmp_file = os.path.join(tmp_dir, 'exs.pl')
    dataset = f'{args.target}_{args.dataset}'
    replacements = {
        '<ROOT>': root_dir,
        '<BACKGROUND>': os.path.join(root_dir, 'data', 'train', f'bg_{dataset}.pl'),
        '<EXAMPLES>': os.path.join(root_dir, 'data', 'train', f'exs_{dataset}.pl')
    }
    copy_file_and_replace(bk_file, bk_tmp_file, replacements)
    copy_file_and_replace(exs_file, exs_tmp_file, replacements)

    if args.datalog:
        new_tmp_dir = os.path.join(root_dir, 'tmp', 'popper_datalog')
        # Need to run in a subprocess because to_datalog.py imports pyswip
        proc = subprocess.run([os.path.join(scripts_dir, 'to_datalog.py'),
                               '--no-progress', tmp_dir, new_tmp_dir])
        if proc.returncode != 0:
            logger.error('ERROR: to_datalog.py failed')
            sys.exit(1)
        else:
            tmp_dir = new_tmp_dir

    result = Queue()
    process = Process(target=run, args=(args, result))
    logger.info('Starting popper')
    process.start()

    prog = None
    intermediate_solutions = []
    start_time = time.time()
    end_time = start_time + padded_timeout
    try:
        logger.debug("Receiving programs from subprocess")
        while process.is_alive() and end_time - time.time() > 0:
            prog = result.get(timeout=end_time - time.time())
            if prog == "Finished":
                break
            intermediate_solutions.append((time.time() - start_time, prog))
            logger.debug("Received program from subprocess")
    except Empty:
        if process.is_alive():
            logger.info('killing popper')
            process.terminate()
            process.join(10)
            if process.is_alive():
                process.kill()
            logger.warning('TIMEOUT, saving best solution so far')

    if prog != None:
        # Save solution
        dl = '_dl' if args.datalog else ''
        bkcons = '_bkcons' if args.bkcons else ''
        solution_target_dir = os.path.join(solution_dir, args.target)
        os.makedirs(solution_target_dir, exist_ok=True)
        solution_path = os.path.join(
            solution_target_dir, f'popper_{args.dataset}{dl}{bkcons}.pl')
        with open(solution_path, 'w') as f:
            f.write(str(prog))
        logger.info("Solution saved to %s", solution_path)
        solution_intermediate_dir = os.path.join(
            solution_dir, args.target, 'intermediate')
        os.makedirs(solution_intermediate_dir, exist_ok=True)
        intermediate_path = os.path.join(
            solution_intermediate_dir, f'popper_{args.dataset}{dl}{bkcons}.csv')
        with open(intermediate_path, 'w') as f:
            csv_writer = csv.writer(f)
            csv_writer.writerow(['time', 'program'])
            csv_writer.writerows(intermediate_solutions)
        logger.info("Intermediate solutions saved to %s", intermediate_path)
    else:
        logger.warning('NO SOLUTION')
