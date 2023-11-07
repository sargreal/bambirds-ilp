#!/usr/bin/env python3
import argparse
import os
import sys
import re
from utils import call_prolog

scripts_dir = os.path.dirname(os.path.realpath(__file__))
root_dir = os.path.dirname(scripts_dir)


RE = "<PROG>\n(.*)<\/PROG>"
CMD = "induce(P),writeln('<PROG>'),numbervars(P,0,_),foreach(member(C,P),(write(C),write('. '))),writeln('</PROG>')"


def read_examples(examples_path):
    with open(examples_path, 'r') as f:
        examples = f.readlines()
        examples = [x.strip() for x in examples]
        # Get all pos examples
        pos_examples = [x for x in examples if x.startswith('pos')]
        # Get all neg examples
        neg_examples = [x for x in examples if x.startswith('neg')]
        # Remove pos and neg prefixes
        pos_examples = [x[4:-2] for x in pos_examples]
        neg_examples = [x[4:-2] for x in neg_examples]
        # Add . to end of each example
        pos_examples = [x + '.' for x in pos_examples]
        neg_examples = [x + '.' for x in neg_examples]
        # Join examples into one string
        pos_examples = '\n'.join(pos_examples)
        neg_examples = '\n'.join(neg_examples)
        return pos_examples, neg_examples


def parse_program(result):
    code = re.search(RE, result)
    code = code.group(1).replace('. ', '.\n') if code else None
    return code


if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument('--target', type=str, default='supports')
    parser.add_argument('--set', type=str, default='sb')
    parser.add_argument('--timeout', type=int, default=600,
                        help='Timeout in seconds')
    args = parser.parse_args()

    path = os.path.join(root_dir, 'data', 'train')
    background_path = os.path.join(path, f'bg_{args.target}_{args.set}.pl')
    examples_path = os.path.join(path, f'exs_{args.target}_{args.set}.pl')

    pos_examples, neg_examples = read_examples(examples_path)

    aleph_template = os.path.join(root_dir, 'aleph', f'{args.target}.pl')

    aleph_tmp_dir = os.path.join(root_dir, 'tmp', 'aleph')
    os.makedirs(aleph_tmp_dir, exist_ok=True)

    aleph_file_path = os.path.join(
        aleph_tmp_dir, f'{args.target}_{args.set}.pl')
    # Write aleph file using template

    with open(aleph_template, 'r') as f:
        template_content = f.read()
        template_content = template_content.replace(
            '<BACKGROUND>', background_path)
        template_content = template_content.replace('<POSITIVE>', pos_examples)
        template_content = template_content.replace('<NEGATIVE>', neg_examples)
        template_content = template_content.replace('<ROOT>', root_dir)
        with open(aleph_file_path, 'w') as f2:
            f2.write(template_content)

    # Run aleph
    out = call_prolog(CMD, files_to_load=[
                      aleph_file_path], timeout=args.timeout)
    program = parse_program(out)
    if not program:
        print('No hypothesis found')
        sys.exit(0)
    print('Hypothesis found')
    print(program)

    # Save hypothesis
    solution_path = os.path.join(
        root_dir, 'solutions', args.target, f'aleph_{args.set}.pl')
    print(f"\nSaving to {solution_path}")

    with open(solution_path, 'w') as f:
        f.write(program)
