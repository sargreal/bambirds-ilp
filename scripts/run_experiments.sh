#!/bin/bash
set -e

# Default timeout is 5 minutes, configure with TIMEOUT env var
timeout=${TIMEOUT:-300}
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

$SCRIPT_DIR/run_popper.py --timeout $timeout --target supports --dataset sb
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target supports --dataset sb
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset sb
$SCRIPT_DIR/run_popper.py --timeout $timeout --target supports --dataset random
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target supports --dataset random
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset random
$SCRIPT_DIR/run_popper.py --timeout $timeout --target supports --dataset all
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target supports --dataset all
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset all
$SCRIPT_DIR/run_popper.py --timeout $timeout --target supports --dataset sb_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target supports --dataset sb_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset sb_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --target supports --dataset random_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target supports --dataset random_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset random_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --target supports --dataset all_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target supports --dataset all_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target supports --dataset all_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --target stable --dataset sb
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target stable --dataset sb
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset sb
$SCRIPT_DIR/run_popper.py --timeout $timeout --target stable --dataset random
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target stable --dataset random
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset random
$SCRIPT_DIR/run_popper.py --timeout $timeout --target stable --dataset all
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target stable --dataset all
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset all
$SCRIPT_DIR/run_popper.py --timeout $timeout --target stable --dataset sb_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target stable --dataset sb_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset sb_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --target stable --dataset random_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target stable --dataset random_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset random_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --target stable --dataset all_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --target stable --dataset all_filter
$SCRIPT_DIR/run_popper.py --timeout $timeout --datalog --bkcons --target stable --dataset all_filter