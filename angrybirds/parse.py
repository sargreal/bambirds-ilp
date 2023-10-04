
import argparse
import csv
import os


def parse_args():
    parser = argparse.ArgumentParser(description='Angry Birds Parser')
    parser.add_argument('--data', dest='data',
                        help='path to folder with data', required=True)
    parser.add_argument('--output', dest='output',
                        help='path to output folder', required=True)
    parser.add_argument('--postfix', default='dangerous')

    return parser.parse_args()


def is_entity(entity: str):
    for basename in ['ice', 'stone', 'wood', 'pig', 'blackbird', 'bluebird', 'redbird', 'whitebird', 'yellowbird', 'struct']:
        if entity.startswith(basename) and len(entity) > len(basename) and entity[len(basename):].isdigit():
            return True
    return False


def rename_entity(entity: str, level: str, shot: str):
    return f"{entity}_{level}_{shot.replace('-','_')}"


def split_fact(fact: str):
    fact = fact.strip().strip('.')
    predicate, args = fact.split('(')
    args = args[:-1].split(',')
    return predicate, args


def create_situation(folder: str, level: str, shot: str):
    situation_file = f"{folder}/situation{level}_{shot}.pl"
    situation = []
    entities = set()
    with open(situation_file, 'r') as f:
        for line in f.readlines():
            predicate, args = split_fact(line)
            for arg in args:
                if is_entity(arg):
                    renamed = rename_entity(arg, level, shot)
                    args[args.index(arg)] = renamed
                    entities.add(renamed)
            situation.append(f"{predicate}({','.join(args)}).")
    for entity in entities:
        situation.append(f"inSituation({entity},{shot}).")
    return situation


def create_shot(level, shot, target, pigsBefore, pigsAfter):
    target = rename_entity(target, level, shot)
    if pigsBefore == pigsAfter:
        return f"neg(dangerous({target}))."
    else:
        return f"pos(dangerous({target}))."


if __name__ == '__main__':
    args = parse_args()

    csv_file = f"{args.data}/shot-results.csv"

    situations = {}
    shots = {}

    with open(csv_file, 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for i, row in enumerate(reader):
            if i == 0:
                continue
            shot_before = "-".join(row[1].split('-')[:-1])
            if shot_before not in situations:
                situations[shot_before] = create_situation(
                    args.data, row[0], shot_before)

            if row[1] + row[2] not in shots:
                shots[row[1] + row[2]] = create_shot(*row)

    with open(f"{args.output}/bg_{args.postfix}.pl", 'w') as f:
        facts = [list(situation) for situation in situations.values()]
        facts = [fact for situation in facts for fact in situation]
        facts.sort()
        for fact in facts:
            f.write(f"{fact}\n")
    with open(f"{args.output}/exs_{args.postfix}.pl", 'w') as f:
        sorted_shots = sorted(shots.values())
        for shot in sorted_shots:
            f.write(f"{shot}\n")
