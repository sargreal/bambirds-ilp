#!/usr/bin/env python

# File to analyze the results of the experiments
import argparse
import os
import shutil

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


def plot_history(file: str):
    """Plot the history of the training of the model

    Args:
        file (str): Path to the history file
    """
    history = pd.read_csv(file)
    history.plot()
    plt.show()
