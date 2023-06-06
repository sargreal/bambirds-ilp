import subprocess
from subprocess import CalledProcessError, TimeoutExpired
import tempfile
import logging
import os
import inspect
import argparse

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


def run_command(cmd, args, timeout = None):
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
        raise CalledProcessError(proc.returncode, cmd, proc.stdout + proc.stderr)
    
    return result

def call_prolog(action, files_to_load=[], timeout=None):
    args = ["-g", action, "-t", "halt", "-q"]

    #TODO(Brad): This feels like a huge hack to make Aleph work
    if len(files_to_load) == 1:
        args.append("-s") 
        args.append(files_to_load[0])

        return run_command('swipl', args, timeout=timeout)
    else:
        with tempfile.NamedTemporaryFile('w') as temp_file:
        # with open('exec.pl' ,'w') as temp_file:
            files = ', '.join([f'\"{f}\"' for f in files_to_load])
            cmd = f":- load_files([{files}],[silent(true)])."
            temp_file.write(cmd)
            temp_file.flush()
            
            args.append("-s") 
            args.append(temp_file.name)

            return run_command('swipl', args, timeout=timeout)


def test(solution, test_settings):
    if not solution:
        return None
    
    cur_dir = current_dir()
        
    with tempfile.NamedTemporaryFile('w') as solution_file:
        lines = [f":- use_module('{os.path.join(cur_dir, 'src', file)}').\n" 
                        for file in ['era', 'contact', 'objects', 'data', 'vertical_allen', 'stable_helpers']]
        lines.append(f':- load_data("{test_settings["bk_file"]}").\n')
        lines.append(solution)
        solution_file.writelines(lines)
        solution_file.flush()

        test_file = curr_dir_relative('test.pl')

        files_to_load = [test_file, test_settings['exs_file'], solution_file.name]
        
        action = 'print_conf_matrix.'
        
        # TODO(Brad): What should the timeout be here?
        result = call_prolog(action, files_to_load=files_to_load, timeout=60)

    return [int(n) for n in result.split(',')] if result else []

def print_result(result: list):
    if len(result) == 0:
        print("Failed to test, please check your solution and background knowledge!")
        return
    print("\tPP\tPN")
    print(f"P\t{result[0]}\t{result[3]}")
    print(f"N\t{result[1]}\t{result[2]}")
    print()
    print('Accuracy:\t', "{:.3f}".format((result[0]+result[2])/sum(result)))
    print('Precision:\t', "{:.3f}".format(result[0]/(result[0]+result[1])))
    print('Recall:\t\t', "{:.3f}".format(result[0]/(result[0]+result[3])))

if __name__ == '__main__':
    parser = argparse.ArgumentParser('test')

    parser.add_argument('--dir', choices=['learning', 'testing'])
    parser.add_argument('set')
    parser.add_argument('solution')

    args = parser.parse_args()

    exs_file = os.path.abspath(os.path.join('data', args.dir, f'exs_{args.set}.pl'))
    bk_file = os.path.abspath(os.path.join('data', args.dir, f'bg_{args.set}.pl'))
    solution = ""
    with open(args.solution, "r") as solution_file:
        solution = "".join(solution_file.readlines())

    result = test(solution, {'exs_file': exs_file, 'bk_file': bk_file})
    print_result(result)
