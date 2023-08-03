#!/usr/bin/env python3
import argparse
import os
import shutil
from pyswip.prolog import Prolog, PrologError
from pyswip.easy import Atom, Variable
from typing import Any, Iterable
import itertools
from tqdm import tqdm
import logging

prolog = Prolog()

variable_list = [f"X{i}" for i in range(100)]

root_dir = os.path.dirname(os.path.realpath(__file__))

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s %(levelname)s %(name)s - %(message)s',
                    datefmt='%H:%M:%S',)
logger = logging.getLogger("to_datalog")


class Predicate:
    name: str
    arguments: list[str]
    arity: int
    directions: list[str]

    def __init__(self, name: str, arguments: list[str], directions: list[str] | None = None):
        self.name = name
        self.arguments = arguments
        self.arity = len(arguments)
        if directions is None:
            directions = ["in"] * self.arity
        self.directions = directions


class Constants:
    constants: dict[str, list[str]]

    def __init__(self):
        self.constants = {}

    def add_constants(self, constants: dict[str, Iterable[str]]):
        for k, v in constants.items():
            if k not in self.constants:
                self.constants[k] = list(v)
            else:
                self.constants[k] = list(set(self.constants[k] + list(v)))

    def add_constant_values(self, name: str, values: Iterable[str]):
        if name not in self.constants:
            self.constants[name] = list(values)
        else:
            self.constants[name] = list(
                set(self.constants[name] + list(values)))

    def __getitem__(self, key):
        return self.constants[key]

    def __str__(self):
        return f"constants({self.constants})"

    def __len__(self):
        return dict_len(self.constants)


class Bias:
    content: dict[str, str | bool | dict[str,  int | tuple[str, ...]]]

    def __init__(self, path: str | None):
        self.content = {}
        if path is not None:
            self.load_bias(path)

    def load_bias(self, path: str):
        with open(path, "r") as f:
            for line in f.readlines():
                if line.startswith("%"):
                    continue
                # get predicate name and arguments

                values = line.strip().strip('.').split("(", 1)
                settings_value = values[0]
                if settings_value not in self.content:
                    self.content[settings_value] = {}
                if len(values) == 2 and type(self.content[settings_value]) == dict:
                    arg = values[1]
                    if settings_value == "direction" or settings_value == "type":
                        setting = self.__parse_tuple_setting(arg)
                    elif settings_value == "body_pred" or settings_value == "head_pred":
                        arg = arg.strip(")").split(",")
                        setting = (arg[0], int(arg[1]))
                    else:
                        v = arg.strip(")").split(",")
                        setting = (v[0], tuple(v[1:]))
                    self.content[settings_value][setting[0]] = setting[1]
                else:
                    self.content[settings_value] = True

    def get_setting(self, name: str):
        if name not in self.content:
            return None
        return self.content[name]

    def get_types(self, name: str):
        setting = self.get_setting("type")
        if type(setting) != dict:
            return None
        value = setting.get(name)
        if type(value) == tuple:
            return value
        return None

    def get_directions(self, name: str) -> None | tuple[str, ...]:
        setting = self.get_setting("direction")
        if type(setting) != dict:
            return None
        value = setting.get(name)
        if type(value) == tuple:
            return value
        return None

    def __create_predicate(self, name: str, arity: int) -> Predicate:
        directions = self.get_directions(name)
        types = self.get_types(name)
        if types == None:
            types = ["X"] * arity
        else:
            types = list(types)
        if type(directions) == tuple:
            return Predicate(name, types, list(directions))
        return Predicate(name, types)

    def get_body_pred(self, name: str) -> None | Predicate:
        body_preds = self.get_setting("body_pred")
        if type(body_preds) != dict:
            return None
        arity = body_preds.get(name)
        if type(arity) == int:
            return self.__create_predicate(name, arity)
        return None

    def get_head_pred(self, name: str) -> None | Predicate:
        head_preds = self.get_setting("head_pred")
        if type(head_preds) != dict:
            return None
        arity = head_preds.get(name)
        if type(arity) == int:
            return self.__create_predicate(name, arity)
        return None

    def get_predicate(self, name: str) -> None | Predicate:
        pred = self.get_body_pred(name)
        if pred != None:
            return pred
        return self.get_head_pred(name)

    def get_predicates(self) -> list[Predicate]:
        return self.get_head_predicates() + self.get_body_predicates()

    def get_body_predicates(self) -> list[Predicate]:
        body_preds = self.get_setting("body_pred")
        if type(body_preds) != dict:
            body_preds = {}

        return filter_none([self.get_body_pred(name) for name in body_preds.keys()])

    def get_head_predicates(self) -> list[Predicate]:
        head_preds = self.get_setting("head_pred")
        if type(head_preds) != dict:
            head_preds = {}
        return filter_none([self.get_body_pred(name) for name in head_preds.keys()])

    def __parse_tuple_setting(self, input: str):
        name, directions = input.split(",", 1)
        directions = directions.strip('(),').split(",")
        return (name, tuple(directions))

    def __getitem__(self, key):
        return self.content[key]

    def __str__(self):
        return f"bias({self.content})"

    def __len__(self):
        return len(self.content)

    def __iter__(self):
        return iter(self.content)

    def __contains__(self, item):
        return item in self.content


def dict_len(d: dict):
    return sum(len(v) for v in d.values())


def filter_none(l: list):
    return [x for x in l if x is not None]


def serialize_argument(argument: list | Atom | int) -> str:
    if type(argument) == list:
        return f'[{",".join(str(e) for e in argument)}]'
    elif type(argument) == Atom:
        return argument.get_value()
    else:
        return argument


def deserialize_argument(argument: str, arg_type: str) -> list | str:
    if arg_type == "L":
        return argument.strip("[]").split(",")
    else:
        return argument


def parse_pl_tuple(pl_tuple: str) -> list[str]:
    elements = pl_tuple.replace(" ", "").replace(
        "(", "").replace(")", "").split(",")
    # remove empty strings
    elements = list(filter(None, elements))
    return elements


def parse_constants(prolog_result: list[Any | Variable | list | dict | None], bias: Bias):
    constants: dict[str, list[str]] = {"E": []}
    for result in prolog_result:
        if type(result) == dict:
            name = result["Name"]
            arguments = result["Arguments"]
            pred = bias.get_predicate(name)
            if pred == None:
                continue
            for pred_type, argument in zip(pred.arguments, arguments):
                if pred_type not in constants:
                    constants[pred_type] = []
                if type(argument) == list:
                    for el in argument:
                        constants["E"].append(el)
                    constants[pred_type].append(serialize_argument(argument))
                else:
                    constants[pred_type].append(serialize_argument(argument))
    return constants


def get_examples(bias: Bias, constants: Constants, value=1):
    if value == 1:
        example_predicate = "pos"
    else:
        example_predicate = "neg"
    try:
        results = list(prolog.query(
            f'{example_predicate}(Example), compound_name_arguments(Example,Name,Arguments)'))
    except PrologError:
        results = []
    constants.add_constants(parse_constants(results, bias))
    for result in results:

        if type(result) == dict:
            name = result["Name"]
            assert type(name) == str
            pred = bias.get_head_pred(name)
            if pred == None:
                continue
            arguments = result["Arguments"]
            assert len(arguments) == len(pred.arguments)
            constant_args = []
            for i, argument in enumerate(arguments):
                constant_args.append(serialize_argument(argument))
            yield name, tuple(constant_args), value


def load_bk(bk_file: str, exs_file: str, bias: Bias, progress=True):
    prolog.consult(exs_file)
    constants = Constants()
    logger.info("Loading examples...")
    pos_examples = list(get_examples(bias, constants, value=1))
    neg_examples = list(get_examples(bias, constants, value=0))
    logger.info("Done loading examples.")
    backgrounds = set()

    prolog.consult(bk_file)

    # perform grounding
    # must be done multiple times to get all constants and relevant background knowledge
    logger.info("Grounding...")
    body_predicates = bias.get_body_predicates()
    for j in range(1):
        tq = tqdm(total=len(body_predicates), disable=not progress)
        old_len = len(backgrounds)
        additional_constants: dict[str, set[str]] = {}
        for pred in body_predicates:
            count = 0
            if progress:
                tq.write(f"Grounding {pred.name}")
            else:
                logger.debug(f"Grounding {pred.name}")
            variables = variable_list[0:pred.arity]
            if all(d == "out" for d in pred.directions):
                results = list(prolog.query(
                    f'{pred.name}({",".join(variables)})'))
                for result in results:
                    if type(result) == dict:
                        args = [serialize_argument(result[var])
                                for var in variables]
                        assert len(args) == len(pred.arguments)
                        for arg_type, arg in zip(pred.arguments, args):
                            if arg_type not in additional_constants:
                                additional_constants[arg_type] = set()
                            additional_constants[arg_type].add(arg)
                        backgrounds.add((pred.name, *args))
                        count += 1
            else:
                all_in = all(d == "in" for d in pred.directions)
                vars = [constants[pred.arguments[i]] if d ==
                        "in" else [variables[i]] for i, d in enumerate(pred.directions)]
                for combination in itertools.product(*vars):
                    prolog_args = [str(el) for i, el in enumerate(combination)]
                    prolog_query = f'{pred.name}({",".join(prolog_args)})'
                    results = list(prolog.query(prolog_query))

                    if all_in and bool(results):
                        backgrounds.add((pred.name, *combination))
                        count += 1
                        continue

                    for result in results:
                        if type(result) == dict:
                            args = [serialize_argument(
                                result[var]) if var in variables else var for var in combination]
                            assert len(args) == len(pred.arguments)
                            for arg_type, arg in zip(pred.arguments, args):
                                if arg_type not in additional_constants:
                                    additional_constants[arg_type] = set()
                                additional_constants[arg_type].add(arg)
                            backgrounds.add((pred.name, *args))
                            count += 1
            if count == 0:
                if progress:
                    tq.write(
                        f"No grounding for {pred.name}, adding dummy grounding")
                else:
                    logger.warning(f"No grounding for {pred.name}, adding dummy grounding")
                backgrounds.add((pred.name, *(["dummy"] * pred.arity)))
            tq.update(1)
        constants.add_constants(additional_constants)
        additional_constants = {}
        if len(backgrounds) == old_len:
            break
    tq.close()
    logger.info("Done grounding.")

    logger.info("Count Predicates:  %6d", len(bias.get_predicates()))
    logger.info("Count Constants:   %6d", len(constants))
    logger.info("Count Examples:    %6d", len(pos_examples + neg_examples))
    logger.info("Count Backgrounds: %6d", len(backgrounds))

    logger.info("Initializing predicates")

    logger.info("Formatting examples")
    examples = []
    for example in pos_examples + neg_examples:
        if example[2] == 1:
            examples.append(f"pos({example[0]}({','.join(example[1])})).\n")
        else:
            examples.append(f"neg({example[0]}({','.join(example[1])})).\n")
    # if len(neg_examples) == 0:
    #     print("Generating negative examples")
    #     for pred in head_predicates:
    #         bk.add_all_neg_example(pred.dname)
    logger.info("Formatting background")
    background_str = []
    for background in backgrounds:
        background_str.append(
            f"{background[0]}({','.join(background[1:])}).\n")
    background_str.sort()
    return examples, background_str


def convert(in_dir: str, out_dir: str, progress = True):
    logger.info('loading data...')
    bias_file = os.path.join(in_dir, 'bias.pl')
    bias = Bias(bias_file)
    examples, background = load_bk(in_dir+'/bk.pl', in_dir +
                                   '/exs.pl', bias, progress=progress)
    logger.info('writing data...')
    os.makedirs(out_dir, exist_ok=True)
    with open(out_dir+'/bk.pl', 'w') as f:
        f.writelines(background)
    with open(out_dir+'/exs.pl', 'w') as f:
        f.writelines(examples)
    if in_dir != out_dir:
        shutil.copyfile(in_dir+'/bias.pl', out_dir+'/bias.pl')
    logger.info('done parsing datalog')


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument(
        'in_dir', help='Folder with bk.pl, bias.pl and exs.pl file', type=str)
    parser.add_argument(
        'out_dir', help='Folder to write new bk.pl, bias.pl and exs.pl', type=str)
    parser.add_argument('--debug', action='store_true')
    parser.add_argument('--no-progress', action='store_false', dest='no_progress')

    args = parser.parse_args()
    if args.debug:
        logger.setLevel(logging.DEBUG)
    convert(args.in_dir, args.out_dir, progress=args.no_progress)
