from testbed import TestBed
import math
import argparse
import random
import time


def enclose(preds, pred):
    return [f'{pred}({s}).\n' for s in preds]

if __name__ == "__main__":

    parser = argparse.ArgumentParser('generate')

    parser.add_argument('out')
    parser.add_argument('exs')
    parser.add_argument('--situations', default=1, type=int)
    parser.add_argument('--head', default = "supports", choices=["supports", "stable"])
    parser.add_argument('--seed', default = None)

    args = parser.parse_args()

    random.seed(args.seed)
    in_situations = []
    materials = []
    shapes = []
    supports_pos = []
    supports_neg = []
    stable_pos = []
    stable_neg = []
    situations = []
    materials.append(f'hasMaterial(ground,hill,-100,-1,200,1).\n')
    shapes.append(f'shape(ground,rect,0,-0.5,0,[1,200,0]).\n')

    for situation in range(args.situations):

        current_situation = f'bg_{situation}'
        f'situation({current_situation}).\n'

        random_remove = False
        min_percent = 0.8
        if args.head == "stable":
            random_remove = True if random.random() > 0.3 else False
            min_percent = random.uniform(0.5, 0.95)

        tb = TestBed(100,100,50,random_remove, min_percent=min_percent, seed=random.random())
        tb.draw(f'before_{situation}.png')
        supports = tb.get_supports()
        neg_supports = []
        for x in range(len(supports)):
            a = random.randint(0,len(tb.shapes) - 1) if random.random() > 0.2 else 'ground'
            b = random.randint(0,len(tb.shapes) - 1)
            while a == b or (a,b) in supports or (a,b) in neg_supports:
                a = random.randint(0,len(tb.shapes) - 1)
                b = random.randint(0,len(tb.shapes) - 1)
            neg_supports.append((a,b))

        situations = [f'situation({current_situation}).\n']
        in_situations.append(f'inSituation(ground,{current_situation}).\n')

        for i, shape in enumerate(tb.shapes):
            bg_object = f'bg_{situation}_{i}'
            in_situations.append(f'inSituation({bg_object},{current_situation}).\n')
            materials.append(f'hasMaterial({bg_object},wood,{round(shape.bb.left)},{round(shape.bb.bottom)},{round(shape.bb.right-shape.bb.left)},{round(shape.bb.top-shape.bb.bottom)}).\n')

            vertices = [f"[{shape.body.position.x + v.x},{shape.body.position.y + v.y}]" for v in shape.get_vertices()]
            shapes.append(f'shape({bg_object},poly,{shape.body.position.x},{shape.body.position.y},{shape.area},[{len(vertices)},{",".join(vertices)}]).\n')

        for a,b in supports:
            if a == 'ground':
                supports_pos.append(f'supports(ground,bg_{situation}_{b})')
            else:
                supports_pos.append(f'supports(bg_{situation}_{a},bg_{situation}_{b})')

        for a,b in neg_supports:
            if a == 'ground':
                supports_neg.append(f'supports(ground,bg_{situation}_{b})')
            else:
                supports_neg.append(f'supports(bg_{situation}_{a},bg_{situation}_{b})')
        
        if args.head == 'supports':
            continue

        tb.run()
        compared = tb.compare()
        for i, compares in enumerate(compared):
            if compares == 'unchanged':
                stable_pos.append(f'stable(bg_{situation}_{i})')
            elif compares == 'moved':
                stable_neg.append(f'stable(bg_{situation}_{i})')
        
        tb.draw(f'after_{situation}.png')

    supports_pos.sort()
    supports_neg.sort()
    stable_pos.sort()
    stable_neg.sort()


    with open(args.out, 'w') as outfile:
        outfile.writelines(situations)
        outfile.writelines(in_situations)
        outfile.writelines(materials)
        outfile.writelines(shapes)
        if args.head == 'stable':
            outfile.writelines([s + '.\n' for s in supports_pos])

    with open(args.exs, 'w') as outfile:
        if args.head == 'supports':
            outfile.writelines(enclose(supports_pos, 'pos'))
            outfile.writelines(enclose(supports_neg, 'neg'))
        elif args.head == 'stable':
            outfile.writelines(enclose(stable_pos, 'pos'))
            outfile.writelines(enclose(stable_neg, 'neg'))



# python3 generate/main.py --situations 4 data/testing/bg_supports.pl data/testing/exs_supports.pl
# python3 generate/main.py --situations 10 data/learning/bg_supports.pl data/learning/exs_supports.pl
# python3 generate/main.py --situations 10 --head stable data/learning/bg_stable.pl data/learning/exs_stable.pl
# python3 generate/main.py --situations 4 --head stable data/testing/bg_stable.pl data/testing/exs_stable.pl
