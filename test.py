import subprocess
from subprocess import CalledProcessError, TimeoutExpired
import tempfile
import logging
import os
import inspect
import argparse
import numpy as np
import csv


def current_dir(file=None):
    if file is None:
        return current_dir(inspect.stack()[1].filename)
    return os.path.dirname(os.path.abspath(file))


def curr_dir_relative(filename):
    return os.sep.join([current_dir(inspect.stack()[1].filename), filename])


def get_logger():
    # TODO(Brad): Configure this somehow
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    return logging.getLogger("bambirds-ilp")


def run_command(cmd, args, timeout=None):
    if not isinstance(cmd, list):
        cmd = [cmd]

    final_args = cmd

    if isinstance(args, dict):
        for (k, v) in args.items():
            final_args.append(k)
            if v != None and v != "":
                final_args.append(v)
    else:
        final_args.extend(args)

    logger = get_logger()
    logger.debug(f"Running command {final_args}")

    try:
        proc = subprocess.run(
            final_args,
            encoding="utf-8",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=timeout)

    except TimeoutExpired as timeout:
        logger.debug(f"Timeout running command {cmd} {args} : {repr(timeout)}")
        return ""

    if proc.stdout:
        result = proc.stdout
        logger.debug(result)
    else:
        result = ""

    if proc.stderr:
        logger.debug(proc.stderr)

    if proc.returncode < 0:
        raise CalledProcessError(proc.returncode, final_args,
                                 proc.stdout + proc.stderr)

    return result


def call_prolog(action, files_to_load=[], timeout=None):
    args = ["-g", action, "-t", "halt", "-q"]

    # TODO(Brad): This feels like a huge hack to make Aleph work
    if len(files_to_load) == 1:
        args.append("-s")
        args.append(files_to_load[0])

        return run_command('swipl', args, timeout=timeout)
    else:
        with tempfile.NamedTemporaryFile('w', suffix=".pl") as temp_file:
            files = ', '.join([f'\"{f}\"' for f in files_to_load])
            cmd = f":- load_files([{files}],[silent(true)])."
            print(cmd)
            temp_file.write(cmd)
            temp_file.flush()

            args.append("-s")
            args.append(temp_file.name)

            try:
                return run_command('swipl', args, timeout=timeout)
            except CalledProcessError:
                # If we get an error, try again, since prolog sometimes
                # consumes too much memory for an unknown reason
                return run_command('swipl', args, timeout=timeout)


def test(solution, test_settings):
    if not solution:
        return None

    cur_dir = current_dir()

    with tempfile.NamedTemporaryFile('w', suffix=".pl") as solution_file:
        lines = [f":- use_module('{os.path.join(cur_dir, 'src', file)}').\n"
                 for file in ['era', 'contact', 'objects', 'data', 'vertical_allen', 'stable_helpers']]
        lines.append(f':- load_data("{test_settings["bk_file"]}").\n')
        lines.append(solution)
        solution_file.writelines(lines)
        solution_file.flush()

        test_file = curr_dir_relative('test.pl')

        files_to_load = [test_file,
                         test_settings['exs_file'], solution_file.name]

        action = 'print_conf_matrix.'

        # TODO(Brad): What should the timeout be here?
        result = call_prolog(action, files_to_load=files_to_load, timeout=60)

    return [int(n) for n in result.split(',')] if result else []


def test_each_line(solution: str, test_settings):
    if not solution:
        return None

    cur_dir = current_dir()

    solution_lines = solution.split('\n')
    # filter out empty and comment lines
    solution_lines = [line.strip()
                      for line in solution_lines if line and not line.startswith('%')]

    print()
    print("TP  FP  line")
    for solution_line in solution_lines:
        result = test(solution_line, test_settings)
        if result:
            tp = result[0]
            fp = result[3]
            print(f"{tp:3}", f"{fp:3}", solution_line)
        else:
            print("Failed\t" + solution_line)


def calculate_scores(result: list[int] | None):
    if not result or len(result) == 0:
        return None
    count = sum(result)
    tp = result[0]
    fn = result[1]
    tn = result[2]
    fp = result[3]
    accuracy = (tp+tn)/count
    precision = tp/(tp+fp) if tp+fp > 0 else np.nan
    recall = tp/(tp+fn) if tp+fn > 0 else np.nan
    f1 = 2*tp/(2*tp+fp+fn) if tp+fp+fn > 0 else np.nan
    return accuracy, precision, recall, f1


def print_result(result: list[int] | None):
    if not result or len(result) == 0:
        print("Failed to test, please check your solution and background knowledge!")
        return
    tp = result[0]
    fn = result[1]
    tn = result[2]
    fp = result[3]
    print("\tPP\tPN")
    print(f"P\t{tp}\t{fn}")
    print(f"N\t{fp}\t{tn}")
    print()
    accuracy, precision, recall, f1 = calculate_scores(result)
    print('Accuracy:\t', f"{accuracy:.3f}")
    print('Precision:\t', f"{precision:.3f}")
    print('Recall:\t\t', f"{recall:.3f}")
    print('F1:\t\t', f"{f1:.3f}")


def load_solution(solution_file: str):
    with open(solution_file) as f:
        solution = "".join(f.readlines())
    return solution


def test_basic(solution: str, directory: str):
    bk_file = os.path.abspath(os.path.join(directory, 'bk.pl'))
    exs_file = os.path.abspath(os.path.join(directory, 'exs.pl'))
    test_file = curr_dir_relative('test.pl')
    result = call_prolog('print_conf_matrix.', files_to_load=[
                         os.path.abspath(solution), bk_file, exs_file, test_file])
    result = [int(n) for n in result.split(',')] if result else []
    print_result(result)


def test_single(solution: str, test_settings):
    result = test(solution, test_settings)
    print_result(result)
    if test_settings['line']:
        test_each_line(solution, test_settings)


def test_batch(solution_dir: str, test_settings):
    print("solution,tp,fn,tn,fp,accuracy,precision,recall,f1")
    for solution_file in os.listdir(solution_dir):
        solution_path = os.path.join(solution_dir, solution_file)
        if not os.path.isfile(solution_path) or not solution_file.endswith('.pl'):
            continue
        print(solution_file[:-3], end=',')
        solution = load_solution(solution_path)
        result = test(solution, test_settings)
        accuracy, precision, recall, f1 = calculate_scores(result)
        print(
            f"{','.join([str(r) for r in result])},{accuracy},{precision},{recall},{f1}")

        if test_settings['line']:
            test_each_line(solution, test_settings)


def test_history(history_file: str, test_settings):
    with open(history_file) as f:
        csv_reader = csv.reader(f)
        next(csv_reader)  # skip header
        print("time,tp,fn,tn,fp,accuracy,precision,recall,f1")
        for row in csv_reader:
            solution = row[1]
            result = test(solution, test_settings)
            accuracy, precision, recall, f1 = calculate_scores(result)
            print(
                f"{row[0]},{','.join([str(r) for r in result])},{accuracy},{precision},{recall},{f1}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser('test')

    parser.add_argument('--dir', choices=['train', 'test'],
                        default='test', help='test either the train or test set (default "test")')
    parser.add_argument('--set', default='supports_all',
                        help='name of the test/train set (default "supports_all")')

    subparsers = parser.add_subparsers(dest='test_type', help='test type')
    basic_parser = subparsers.add_parser(
        'basic', help='Test a single solution without specific data')
    single_parser = subparsers.add_parser(
        'single', help='Test a single solution')

    batch_parser = subparsers.add_parser(
        'batch', help='Test a batch of solutions in a folder')

    history_parser = subparsers.add_parser(
        'history', help='Test the whole history of a solution, for plotting the learning curve')

    history_parser.set_defaults(func=test_history)

    basic_parser.add_argument(
        'dir', type=str, help='path to a popper directory (with bk.pl and exs.pl))')
    basic_parser.add_argument('solution', type=str,
                              help='path to solution file')

    single_parser.add_argument('--line', action='store_true',
                               help='test each line in the solution file, does not work with recursion')
    single_parser.add_argument(
        'solution', type=str, help='path to solution file')

    batch_parser.add_argument(
        'folder', type=str, help='path to folder containing solution files')

    history_parser.add_argument(
        'history', type=str, help='path to solution history file (indermediate solutions in intermediate/solution.csv)')

    args = parser.parse_args()

    if args.test_type == "basic":
        test_basic(args.solution, args.dir)
        exit()

    exs_file = os.path.abspath(os.path.join(
        'data', args.dir, f'exs_{args.set}.pl'))
    bk_file = os.path.abspath(os.path.join(
        'data', args.dir, f'bg_{args.set}.pl'))
    assert os.path.isfile(exs_file), f"File {exs_file} does not exist!"
    assert os.path.isfile(bk_file), f"File {bk_file} does not exist!"
    test_settings = {'exs_file': exs_file,
                     'bk_file': bk_file, 'line': False}

    if args.test_type == "single":
        test_settings['line'] = args.line
        test_single(args.solution, test_settings)
    elif args.test_type == "batch":
        test_batch(args.folder, test_settings)
    elif args.test_type == "history":
        test_history(args.history, test_settings)
