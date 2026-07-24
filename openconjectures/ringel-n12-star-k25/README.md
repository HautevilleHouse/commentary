# Ringel conjecture: bounded `n=12`, star `K1,12` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=12` for the 12-edge star `K1,12` in `K25`. For each center `c` from 0 through 24, take leaves `c+1,c+2,...,c+12 (mod 25)`. These 25 stars have 300 pairwise distinct edges and cover every edge of `K25`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: twenty-five K1,12 copies partition E(K25)`.
