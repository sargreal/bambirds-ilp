# Research Project ILP for AIBirds

This work is highly inspired by *Renz and Zhang 2014*, **Qualitative Spatial Representation and Reasoning in Angry Birds: The Extended Rectangle Algebra**.

Some parts for the execution and testing are from/inspired by https://github.com/logic-and-learning-lab/ilp-experiments

## Reqirements

- Only tested on linux
- Python (3.10 used, lower and higher may work)
- swipl
- pip packages: pyswip, numpy, pandas, matplotlib, seaborn
- Popper (Adjusted pip installation script to get it running as an executable, see https://github.com/logic-and-learning-lab/Popper/pull/75)
- optionally Aleph, installed using Swipl packages

## Project Layout

- aleph and popper folder: templates for learning
- generate: Utilities for generating train and test data
- data: generated train and test data
- src: source files for background knowledge
- solutions: resulting programs from popper, aleph and manual solutions for comparison
    - sub folder intermediate: intermediate solutions to analyze the learn progression
- evaluation: collated evaluation files from the solutionms on test data
- scripts: Execution of generating, running and evaluating. Python scripts with options, bash scripts as complete execution

## Available datasets

- Sciencebirds: Randomly generated Scenes using the sciencebirds level generator (only regular rectangles)
- Random: Randomly generated Scenes by dropping Objects from random points (additionally angular rectangles)

> Additionally, each dataset has the option **filtered**. That means that for the supports predicate, that only those object combinations are valid, if the supporting object was removed. This woul roughly correspond to a `supports_majority` predicate

## Examples

### Learning the supports predicate with popper

```bash
python scripts/run_popper.py --target supports --dataset all
```
The solution will be saved to `solutions/supports/popper_all`

Evaluate the solution directly:
```bash
python scripts/test.py --set supports_all --dir test single solutions/supports/popper_all
# Optionally add --line to get results for each line
python scripts/test.py --set supports_all --dir test single solutions/supports/popper_all --line
```

### Learning the supports predicate with aleph

```bash
python scripts/run_aleph.py --set all --target supports
```
The solution will be saved to `solutions/supports/aleph_all`

Evaluate equivalent to above

### Batch Learning

1. Adjust `scripts/run_experiments.sh` to your liking and then run it.
2. Run `scripts/evaluation.sh [target]`. The plots are  automatically generated using `scripts/analysis.py`

