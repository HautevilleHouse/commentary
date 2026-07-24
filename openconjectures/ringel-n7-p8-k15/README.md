# Ringel conjecture: bounded `n=7`, path `P8` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=7` for the 7-edge path `P8` in `K15`. The 15 path embeddings are cyclic shifts modulo 15 of `[0,7,1,6,2,5,3,4]`:

```text
[0,7,1,6,2,5,3,4], [1,8,2,7,3,6,4,5], [2,9,3,8,4,7,5,6],
[3,10,4,9,5,8,6,7], [4,11,5,10,6,9,7,8], [5,12,6,11,7,10,8,9],
[6,13,7,12,8,11,9,10], [7,14,8,13,9,12,10,11], [8,0,9,14,10,13,11,12],
[9,1,10,0,11,14,12,13], [10,2,11,1,12,0,13,14], [11,3,12,2,13,1,14,0],
[12,4,13,3,14,2,0,1], [13,5,14,4,0,3,1,2], [14,6,0,5,1,4,2,3]
```

Their 105 edges are pairwise distinct and cover every edge of `K15`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: fifteen P8 copies partition E(K15)`.
