import subprocess
from subprocess import CalledProcessError, TimeoutExpired
import os
import inspect
import logging
import tempfile


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
            # print(cmd)
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
