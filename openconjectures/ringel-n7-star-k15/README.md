# Ringel conjecture: bounded `n=7`, star `K1,7` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=7` for the 7-edge star `K1,7` in `K15`. For each center `c` from 0 through 14, take leaves `c+1,c+2,...,c+7 (mod 15)`. These 15 stars have 105 pairwise distinct edges and cover every edge of `K15`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: fifteen K1,7 copies partition E(K15)`.
