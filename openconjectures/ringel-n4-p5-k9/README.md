# Ringel conjecture: bounded `n=4`, path `P5` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=4` for the 4-edge path `P5` in `K9`. The nine path embeddings are:

```text
[0,1,3,6,2], [1,2,4,7,3], [2,3,5,8,4],
[3,4,6,0,5], [4,5,7,1,6], [5,6,8,2,7],
[6,7,0,3,8], [7,8,1,4,0], [8,0,2,5,1]
```

Their 36 edges are pairwise distinct and cover every edge of `K9`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: nine P5 copies partition E(K9)`.
