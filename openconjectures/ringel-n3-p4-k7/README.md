# Ringel conjecture: bounded `n=3`, path `P4` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=3` for the 3-edge path `P4` in `K7`. The seven path embeddings are:

```text
[0,1,3,6], [1,2,4,0], [2,3,5,1], [3,4,6,2],
[4,5,0,3], [5,6,1,4], [6,0,2,5]
```

Each list gives the path in order. Their 21 edges are pairwise disjoint and cover every edge of `K7`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: seven P4 copies partition E(K7)`.
