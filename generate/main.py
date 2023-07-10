from testbed import TestBed
from tqdm import trange, tqdm
import math
import argparse
import random
import time
import os
import shutil
import pymunk


def enclose(preds, pred):
    return [f'{pred}({s}).\n' for s in preds]


current_directory = os.path.dirname(os.path.abspath(__file__))
root_directory = os.path.abspath(os.path.join(current_directory, '..'))

if __name__ == "__main__":

    parser = argparse.ArgumentParser('generate')

    parser.add_argument('folder', choices=[
                        'train', 'test'], help='The folder to save the generated files to')
    parser.add_argument('--suffix', required=True)
    parser.add_argument('--situations', default=1, type=int)
    parser.add_argument('--head', default="supports",
                        choices=["supports", "stable"])
    parser.add_argument('--seed', default=None)
    parser.add_argument('--world', default="science_birds",
                        choices=["science_birds", "random", 'all'])
    parser.add_argument('--filter-supports', default=False, action='store_true', dest='filter_supports',
                        help='Whether to filter supports for if the supported object would move if the supporter was removed')

    args = parser.parse_args()
    suffix = f'_{args.suffix}' if args.suffix else ''
    background_file = os.path.join(
        root_directory, 'data', args.folder, f'bg_{args.head}{suffix}.pl')
    examples_file = os.path.join(
        root_directory, 'data', args.folder, f'exs_{args.head}{suffix}.pl')

    img_folder = os.path.join(root_directory, 'data',
                              args.folder, 'img', f"{args.head}{suffix}")
    if os.path.exists(img_folder):
        shutil.rmtree(img_folder)
    os.makedirs(img_folder)

    random.seed(args.seed)
    in_situations = []
    materials = []
    shapes = []
    supports_pos = []
    supports_neg = []
    stable_pos = []
    stable_neg = []
    situations = []

    for situation in trange(args.situations):

        current_situation = f'bg_{situation}'
        f'situation({current_situation}).\n'

        random_remove = False
        min_percent = 0.8
        if args.head == "stable":
            random_remove = True if random.random() > 0.3 else False
            min_percent = random.uniform(0.5, 0.95)

        tb = TestBed(100, 100, 50, random_remove,
                     min_percent=min_percent, seed=random.random())
        if args.world == "science_birds":
            tb.create_sb_world()
        elif args.world == "random":
            tb.create_random_world()
        elif args.world == "all":
            random.choice([tb.create_sb_world, tb.create_random_world])()
        else:
            raise Exception("Invalid world type")
        tb.draw(os.path.join(img_folder, f'sit_{situation}_before.png'))
        supports = tb.get_supports()
        if args.filter_supports:
            supports = tb.filter_supports(supports)

        neg_supports = []
        for x in range(len(supports)):
            a = random.randint(0, len(tb.shapes) -
                               1) if random.random() > 0.2 else 'ground'
            b = random.randint(0, len(tb.shapes) - 1)
            while a == b or (a, b) in supports or (a, b) in neg_supports:
                a = random.randint(0, len(tb.shapes) - 1)
                b = random.randint(0, len(tb.shapes) - 1)
            neg_supports.append((a, b))

        situations = [f'situation({current_situation}).\n']

        for i, shape in enumerate(tb.shapes):
            bg_object = f'bg_{situation}_{i}'
            in_situations.append(
                f'inSituation({bg_object},{current_situation}).\n')
            material = "wood" if shape.body.body_type == pymunk.Body.DYNAMIC else "hill"
            materials.append(
                f'hasMaterial({bg_object},{material},{round(shape.bb.left)},{round(shape.bb.bottom)},{round(shape.bb.right-shape.bb.left)},{round(shape.bb.top-shape.bb.bottom)}).\n')

            vertices = [
                f"[{shape.body.position.x + v.x},{shape.body.position.y + v.y}]" for v in shape.get_vertices()]
            shapes.append(
                f'shape({bg_object},poly,{shape.body.position.x},{shape.body.position.y},{shape.area},[{len(vertices)},{",".join(vertices)}]).\n')

        for a, b in supports:
            if a == 'ground':
                supports_pos.append(f'supports(ground,bg_{situation}_{b})')
            else:
                supports_pos.append(
                    f'supports(bg_{situation}_{a},bg_{situation}_{b})')

        for a, b in neg_supports:
            if a == 'ground':
                supports_neg.append(f'supports(ground,bg_{situation}_{b})')
            else:
                supports_neg.append(
                    f'supports(bg_{situation}_{a},bg_{situation}_{b})')

        if args.head == 'supports':
            continue

        tb.run()
        compared = tb.compare()
        for i, compares in enumerate(compared):
            if compares == 'unchanged':
                stable_pos.append(f'stable(bg_{situation}_{i})')
            elif compares == 'moved':
                stable_neg.append(f'stable(bg_{situation}_{i})')

        tb.draw(os.path.join(img_folder, f'sit_{situation}_after.png'))

    supports_pos.sort()
    supports_neg.sort()
    stable_pos.sort()
    stable_neg.sort()

    with open(background_file, 'w') as outfile:
        outfile.writelines(situations)
        outfile.writelines(in_situations)
        outfile.writelines(materials)
        outfile.writelines(shapes)
        if args.head == 'stable':
            outfile.writelines([s + '.\n' for s in supports_pos])

    with open(examples_file, 'w') as outfile:
        if args.head == 'supports':
            outfile.writelines(enclose(supports_pos, 'pos'))
            outfile.writelines(enclose(supports_neg, 'neg'))
        elif args.head == 'stable':
            outfile.writelines(enclose(stable_pos, 'pos'))
            outfile.writelines(enclose(stable_neg, 'neg'))

"""
python3 generate/main.py --situations 4   --suffix sb     test
python3 generate/main.py --situations 10  --suffix sb     train
python3 generate/main.py --situations 4   --world random  --suffix random  test
python3 generate/main.py --situations 10  --world random  --suffix random  train
python3 generate/main.py --situations 10  --world all  --suffix all  test
python3 generate/main.py --situations 10  --world all  --suffix all  train
python3 generate/main.py --situations 10  --head stable --suffix sb  train
python3 generate/main.py --situations 4   --head stable --suffix sb  test
python3 generate/main.py --situations 20  --head stable --world random  --suffix random   train
python3 generate/main.py --situations 10   --head stable --world random  --suffix random   test
python3 generate/main.py --situations 20  --head stable --world all  --suffix all   train
python3 generate/main.py --situations 10   --head stable --world all  --suffix all   test
"""
