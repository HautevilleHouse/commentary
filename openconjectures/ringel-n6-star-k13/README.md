# Ringel conjecture: bounded `n=6`, star `K1,6` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=6` for the 6-edge star `K1,6` in `K13`. Each tuple is `(center, six leaves)`; the 13 cyclic embeddings are:

```text
(0,1,2,3,4,5,6), (1,2,3,4,5,6,7), (2,3,4,5,6,7,8),
(3,4,5,6,7,8,9), (4,5,6,7,8,9,10), (5,6,7,8,9,10,11),
(6,7,8,9,10,11,12), (7,8,9,10,11,12,0), (8,9,10,11,12,0,1),
(9,10,11,12,0,1,2), (10,11,12,0,1,2,3), (11,12,0,1,2,3,4),
(12,0,1,2,3,4,5)
```

Their 78 edges are pairwise distinct and cover every edge of `K13`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: thirteen K1,6 copies partition E(K13)`.
