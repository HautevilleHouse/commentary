# Ringel conjecture: bounded `n=11`, star `K1,11` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=11` for the 11-edge star `K1,11` in `K23`. For each center `c` from 0 through 22, take leaves `c+1,c+2,...,c+11 (mod 23)`. These 23 stars have 253 pairwise distinct edges and cover every edge of `K23`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: twenty-three K1,11 copies partition E(K23)`.
