#!/bin/bash
set -e

# Default timeout is 5 minutes, configure with TIMEOUT env var
timeout=${TIMEOUT:-300}

./run_popper.py --timeout $timeout --target supports --dataset sb
./run_popper.py --timeout $timeout --datalog --target supports --dataset sb
./run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset sb
./run_popper.py --timeout $timeout --target supports --dataset random
./run_popper.py --timeout $timeout --datalog --target supports --dataset random
./run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset random
./run_popper.py --timeout $timeout --target supports --dataset all
./run_popper.py --timeout $timeout --datalog --target supports --dataset all
./run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset all
./run_popper.py --timeout $timeout --target supports --dataset sb_filter
./run_popper.py --timeout $timeout --datalog --target supports --dataset sb_filter
./run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset sb_filter
./run_popper.py --timeout $timeout --target supports --dataset random_filter
./run_popper.py --timeout $timeout --datalog --target supports --dataset random_filter
./run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset random_filter
./run_popper.py --timeout $timeout --target supports --dataset all_filter
./run_popper.py --timeout $timeout --datalog --target supports --dataset all_filter
./run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset all_filter
./run_popper.py --timeout $timeout --target stable --dataset sb
./run_popper.py --timeout $timeout --datalog --target stable --dataset sb
./run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset sb
./run_popper.py --timeout $timeout --target stable --dataset random
./run_popper.py --timeout $timeout --datalog --target stable --dataset random
./run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset random
./run_popper.py --timeout $timeout --target stable --dataset all
./run_popper.py --timeout $timeout --datalog --target stable --dataset all
./run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset all
./run_popper.py --timeout $timeout --target stable --dataset sb_filter
./run_popper.py --timeout $timeout --datalog --target stable --dataset sb_filter
./run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset sb_filter
./run_popper.py --timeout $timeout --target stable --dataset random_filter
./run_popper.py --timeout $timeout --datalog --target stable --dataset random_filter
./run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset random_filter
./run_popper.py --timeout $timeout --target stable --dataset all_filter
./run_popper.py --timeout $timeout --datalog --target stable --dataset all_filter
./run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset all_filter