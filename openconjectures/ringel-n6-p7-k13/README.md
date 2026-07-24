# Ringel conjecture: bounded `n=6`, path `P7` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=6` for the 6-edge path `P7` in `K13`. The 13 path embeddings are:

```text
[0,6,1,5,2,4,3], [1,7,2,6,3,5,4], [2,8,3,7,4,6,5],
[3,9,4,8,5,7,6], [4,10,5,9,6,8,7], [5,11,6,10,7,9,8],
[6,12,7,11,8,10,9], [7,0,8,12,9,11,10], [8,1,9,0,10,12,11],
[9,2,10,1,11,0,12], [10,3,11,2,12,1,0], [11,4,12,3,0,2,1],
[12,5,0,4,1,3,2]
```

Their 78 edges are pairwise distinct and cover every edge of `K13`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: thirteen P7 copies partition E(K13)`.
