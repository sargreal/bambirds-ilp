#!/bin/bash

set -e

echo "Generating data for training and testing"
echo "----------------------------------------"

echo "generating supports"
echo "  science_birds train"
python3 generate/main.py --situations 10  --suffix sb     train
echo "  science_birds test"
python3 generate/main.py --situations 4   --suffix sb     test
echo "  random train"
python3 generate/main.py --situations 10  --world random  --suffix random  train
echo "  random test"
python3 generate/main.py --situations 4   --world random  --suffix random  test
echo "  all train"
python3 generate/main.py --situations 10  --world all  --suffix all  train
echo "  all test"
python3 generate/main.py --situations 10  --world all  --suffix all  test
echo "generating stable"
echo "  science_birds train"
python3 generate/main.py --situations 10  --head stable --suffix sb  train
echo "  science_birds test"
python3 generate/main.py --situations 4   --head stable --suffix sb  test
echo "  random train"
python3 generate/main.py --situations 20  --head stable --world random  --suffix random   train
echo "  random test"
python3 generate/main.py --situations 10   --head stable --world random  --suffix random   test
echo "  all train"
python3 generate/main.py --situations 20  --head stable --world all  --suffix all   train
echo "  all test"
python3 generate/main.py --situations 10   --head stable --world all  --suffix all   test

echo "generating supports with filters"
echo "  science_birds train"
python3 generate/main.py --situations 10  --suffix sb_filter  --filter-supports   train
echo "  science_birds test"
python3 generate/main.py --situations 4   --suffix sb_filter  --filter-supports   test
echo "  random train"
python3 generate/main.py --situations 10  --world random  --suffix random_filter --filter-supports train
echo "  random test"
python3 generate/main.py --situations 4   --world random  --suffix random_filter --filter-supports test
echo "  all train"
python3 generate/main.py --situations 10  --world all  --suffix all_filter --filter-supports train
echo "  all test"
python3 generate/main.py --situations 10  --world all  --suffix all_filter --filter-supports test
echo "generating stable with filters"
echo "  science_birds train"
python3 generate/main.py --situations 10  --head stable --suffix sb_filter --filter-supports train
echo "  science_birds test"
python3 generate/main.py --situations 4   --head stable --suffix sb_filter --filter-supports test
echo "  random train"
python3 generate/main.py --situations 20  --head stable --world random  --suffix random_filter --filter-supports  train
echo "  random test"
python3 generate/main.py --situations 10   --head stable --world random  --suffix random_filter --filter-supports  test
echo "  all train"
python3 generate/main.py --situations 20  --head stable --world all  --suffix all_filter --filter-supports  train
echo "  all test"
python3 generate/main.py --situations 10   --head stable --world all  --suffix all_filter --filter-supports  test