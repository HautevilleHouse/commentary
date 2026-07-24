# Ringel conjecture: bounded `n=8`, star `K1,8` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=8` for the 8-edge star `K1,8` in `K17`. For each center `c` from 0 through 16, take leaves `c+1,c+2,...,c+8 (mod 17)`. These 17 stars have 136 pairwise distinct edges and cover every edge of `K17`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: seventeen K1,8 copies partition E(K17)`.
