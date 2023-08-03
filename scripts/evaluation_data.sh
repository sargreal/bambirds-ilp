#!/bin/bash

# This script is used to generate the evaluation data

target=${1:-"supports"}

mkdir -p evaluation/${target}/history

for dataset in $(ls data/test/bg_${target}*.pl); do

    # remove prefix "data/test/bg_" and suffix ".pl"
    dataset=${dataset:13:-3}
    echo "Processing $dataset"
    # generate the evaluation data
    python3 test.py --dir test --set $dataset batch solutions/${target} > evaluation/${target}/$dataset.csv
done

for file in $(ls solutions/${target}/intermediate); do
    echo "Processing $file"
    # remove prefix "popper_" and suffix ".csv"
    dataset=${file:7:-4}
    # remove _dl and/or _bkcons from the name
    dataset=${dataset%_bkcons}
    dataset=${dataset%_dl}
    echo "Dataset: $dataset"
    # generate the evaluation data
    python3 test.py --dir train --set ${target}_$dataset history solutions/${target}/intermediate/$file > evaluation/${target}/history/train_$file
    python3 test.py --dir test --set ${target}_$dataset history solutions/${target}/intermediate/$file > evaluation/${target}/history/test_$file
done