# Ringel conjecture: bounded `n=13`, star `K1,13` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=13` for the 13-edge star `K1,13` in `K27`. For each center `c` from 0 through 26, take leaves `c+1,c+2,...,c+13 (mod 27)`. These 27 stars have 351 pairwise distinct edges and cover every edge of `K27`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: twenty-seven K1,13 copies partition E(K27)`.

Lean Lake certificate (stdlib-only) for the same cyclic star partition:

```sh
cd lean && lake build
```
