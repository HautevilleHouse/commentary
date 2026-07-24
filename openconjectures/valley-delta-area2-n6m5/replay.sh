#!/bin/sh
set -eu
cd "$(dirname "$0")"
tmp="$(mktemp -d "${TMPDIR:-/tmp}/valley-delta.XXXXXX")"
trap 'rm -rf "$tmp"' EXIT HUP INT TERM
c++ -std=c++17 -O2 -Wall -Wextra -pedantic verify_area2_n6m5.cpp -o "$tmp/verify_area2_n6m5"
"$tmp/verify_area2_n6m5"
