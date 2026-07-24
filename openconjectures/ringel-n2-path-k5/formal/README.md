# Lean-native replay

`RingelN2.lean` is a bounded Lean 4.31.0 replay of the listed five `P3`
embeddings partitioning the ten edges of `K5`. It proves distinctness of the
edge lists, validity of each listed path, and the two-way finite membership
check. It does not prove the general Ringel conjecture.

Run from this directory:

```sh
lean formal/RingelN2.lean
python3 verify.py
```

The packet carries both the standalone Lean replay and a separately pinned
Mathlib-backed replay under `formal/mathlib/`.
