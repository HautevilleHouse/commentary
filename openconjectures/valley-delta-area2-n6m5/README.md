# Valley Delta area-two slice: n=6, M=5

This packet records an internally verified finite replay of the area-two
bounded slice of Conjecture 8.2 in arXiv:2606.14877v1. It checks the exact
source-defined valley-decorated objects for `n=6` and label alphabet
`{1,2,3,4,5}`.

Result: the diagonal-blind refinement has 143,649 classes and 0 asymmetric
classes; the per-diagonal refinement has 149,388 classes and 0 asymmetric
classes. The unrestricted conjecture is not settled.

## Replays

Separate C++ replay:

```sh
clang++ -std=c++17 -O2 -Wall -Wextra -pedantic \
  checkers/valley_delta_area2_n6m5_verify.cpp -o /tmp/valley_delta_area2_n6m5_verify
/tmp/valley_delta_area2_n6m5_verify
```

The source ancillary Python replay:

```sh
python3 - <<'PY'
import sys
sys.path.insert(0, "checkers")
import area2
out = area2.run(6, 5)
assert out['diag-blind'][:2] == (143649, 0)
assert out['per-diagonal'][:2] == (149388, 0)
print('PASS', out['diag-blind'][:2], out['per-diagonal'][:2])
PY
```

The exact bounded statement, source hashes, claim boundary, and replay
receipt are in `source/source_exact_statement.txt` and `result.json`.
