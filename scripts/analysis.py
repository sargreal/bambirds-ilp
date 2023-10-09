#!/usr/bin/env python

# File to analyze the results of the experiments
import argparse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os


scripts_dir = os.path.dirname(os.path.realpath(__file__))
root_dir = os.path.dirname(scripts_dir)

def plot_history(target: str, setting: str, save: bool):
    """Plot the history of the training of the model

    Args:
        file (str): Path to the history file
    """
    train_history = pd.read_csv(f"{root_dir}/evaluation/{target}/history/train_{setting}.csv")
    test_history = pd.read_csv(f"{root_dir}/evaluation/{target}/history/test_{setting}.csv")
    sns.lineplot(data=train_history, x="time", y="precision", label="Precision Train")
    sns.lineplot(data=test_history, x="time", y="precision", label="Precision Test")
    sns.lineplot(data=train_history, x="time", y="recall", label="Recall Train")
    sns.lineplot(data=test_history, x="time", y="recall", label="Recall Test")
    plt.ylim(-0.05, 1.05)
    plt.xlim(0,300)
    plt.title(f"Training and Test Score for {target} with {setting}")
    if save:
        plt.savefig(f"{root_dir}/evaluation/{target}/history/{setting}.png", bbox_inches='tight')
        print(f"Saved plot to {root_dir}/evaluation/{target}/history/{setting}.png")
    else:
        plt.show()

def plot_eval(target: str, setting: str, save: bool):
    """Plot the evaluation of the models

    Args:
        file (str): Path to the history file
    """
    eval = pd.read_csv(f"{root_dir}/evaluation/{target}/{setting}.csv")
    # Sort the dataframe by the solution
    eval = eval.sort_values(by=["solution"])
    # Rotate the labels on the x-axis
    plt.xticks(rotation=90)
    sns.barplot(data=eval, x="solution", y="f1", label="F1")
    plt.ylim(0, 1)
    plt.title(f"Evaluation Scores for {target}")
    if save:
        plt.savefig(f"{root_dir}/evaluation/{target}/{setting}.png", bbox_inches='tight')
        print(f"Saved plot to {root_dir}/evaluation/{target}/{setting}.png")
    else:
        plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser("analyze")
    parser.add_argument("--target", default="supports", help="name of the problem (default 'supports')")
    parser.add_argument("--setting", default="all", help="name of the specific setting (default 'all'). For plot=history, use '[system]_all' as only single systems are supported there")
    parser.add_argument("--plot", choices=["history", "eval"], default="eval", help="plot either the history or the evaluation (default 'eval')")
    parser.add_argument("--save", default=False, action="store_true", help="save the plot instead of showing it")
    args = parser.parse_args()

    if args.plot == "history":
        plot_history(args.target, args.setting, args.save)
    elif args.plot == "eval":
        plot_eval(args.target, args.setting, args.save)