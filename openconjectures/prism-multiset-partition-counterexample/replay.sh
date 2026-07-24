#!/bin/sh
set -eu
cd "$(dirname "$0")"
python3 checkers/verify_counterexample.py
