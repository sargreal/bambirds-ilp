#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(dirname -- "$SCRIPT_DIR")
GENERATE_DIR=$ROOT_DIR/generate
GENERATE=$GENERATE_DIR/main.py

echo "Generating data for training and testing"
echo "----------------------------------------"

echo "generating supports"
echo "  science_birds train"
python3 $GENERATE --situations 20  --suffix sb     train
echo "  science_birds test"
python3 $GENERATE --situations 10   --suffix sb     test
echo "  random train"
python3 $GENERATE --situations 20  --world random  --suffix random  train
echo "  random test"
python3 $GENERATE --situations 10   --world random  --suffix random  test
echo "  all train"
python3 $GENERATE --situations 20  --world all  --suffix all  train
echo "  all test"
python3 $GENERATE --situations 10  --world all  --suffix all  test
# echo "generating stable"
# echo "  science_birds train"
# python3 $GENERATE --situations 20  --head stable --suffix sb  train
# echo "  science_birds test"
# python3 $GENERATE --situations 10   --head stable --suffix sb  test
# echo "  random train"
# python3 $GENERATE --situations 20  --head stable --world random  --suffix random   train
# echo "  random test"
# python3 $GENERATE --situations 10   --head stable --world random  --suffix random   test
# echo "  all train"
# python3 $GENERATE --situations 20  --head stable --world all  --suffix all   train
# echo "  all test"
# python3 $GENERATE --situations 10   --head stable --world all  --suffix all   test

echo "generating supports with filters"
echo "  science_birds train"
python3 $GENERATE --situations 20  --suffix sb_filter  --filter-supports   train
echo "  science_birds test"
python3 $GENERATE --situations 10   --suffix sb_filter  --filter-supports   test
echo "  random train"
python3 $GENERATE --situations 20  --world random  --suffix random_filter --filter-supports train
echo "  random test"
python3 $GENERATE --situations 10   --world random  --suffix random_filter --filter-supports test
echo "  all train"
python3 $GENERATE --situations 20  --world all  --suffix all_filter --filter-supports train
echo "  all test"
python3 $GENERATE --situations 10  --world all  --suffix all_filter --filter-supports test
# echo "generating stable with filters"
# echo "  science_birds train"
# python3 $GENERATE --situations 20  --head stable --suffix sb_filter --filter-supports train
# echo "  science_birds test"
# python3 $GENERATE --situations 10   --head stable --suffix sb_filter --filter-supports test
# echo "  random train"
# python3 $GENERATE --situations 20  --head stable --world random  --suffix random_filter --filter-supports  train
# echo "  random test"
# python3 $GENERATE --situations 10   --head stable --world random  --suffix random_filter --filter-supports  test
# echo "  all train"
# python3 $GENERATE --situations 20  --head stable --world all  --suffix all_filter --filter-supports  train
# echo "  all test"
# python3 $GENERATE --situations 10   --head stable --world all  --suffix all_filter --filter-supports  test