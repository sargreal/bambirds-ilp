#!/bin/bash

set -e

# This script is used to generate the evaluation data

target=${1:-"supports"}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(dirname -- "$SCRIPT_DIR")

mkdir -p ${ROOT_DIR}/evaluation/${target}/history


echo ""
echo "Generating evaluation data"

# for dataset in $(ls ${ROOT_DIR}/data/test/bg_${target}*.pl); do

#     # remove prefix "${ROOT_DIR}/data/test/bg_" and suffix ".pl"
#     dataset=$(basename $dataset)
#     dataset=${dataset:3:-3}
#     # remote target from dataset name
#     file=${dataset#"${target}_"}
#     echo "Processing $dataset"
#     # generate the evaluation data
#     python3 ${SCRIPT_DIR}/test.py --debug --output ${ROOT_DIR}/evaluation/${target}/$file.csv --dir test --set $dataset batch ${ROOT_DIR}/solutions/${target}
#     python3 ${SCRIPT_DIR}/analysis.py --target $target --setting $file --plot eval --save
# done

echo ""
echo "Generating history data"

for file in $(ls ${ROOT_DIR}/solutions/${target}/intermediate); do
    echo "Processing $file"
    # remove prefix "popper_" and suffix ".csv"

    name=${file:0:-4}
    dataset=${file:7:-4}
    # remove _dl and/or _bkcons from the name
    dataset=${dataset%_bkcons}
    dataset=${dataset%_dl}
    echo "Dataset: $dataset"
    # generate the evaluation data
    # python3 ${SCRIPT_DIR}/test.py --dir train --set ${target}_$dataset history ${ROOT_DIR}/solutions/${target}/intermediate/$file > ${ROOT_DIR}/evaluation/${target}/history/train_$file
    # python3 ${SCRIPT_DIR}/test.py --dir test --set ${target}_$dataset history ${ROOT_DIR}/solutions/${target}/intermediate/$file > ${ROOT_DIR}/evaluation/${target}/history/test_$file
    python3 ${SCRIPT_DIR}/analysis.py --target $target --setting $name --plot history --save
done