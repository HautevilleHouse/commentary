# Ringel conjecture: bounded `n=5`, path `P6` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=5` for the 5-edge path `P6` in `K11`. The 11 path embeddings are the cyclic shifts modulo 11 of `[0,5,1,4,2,3]`:

```text
[0,5,1,4,2,3], [1,6,2,5,3,4], [2,7,3,6,4,5],
[3,8,4,7,5,6], [4,9,5,8,6,7], [5,10,6,9,7,8],
[6,0,7,10,8,9], [7,1,8,0,9,10], [8,2,9,1,10,0],
[9,3,10,2,0,1], [10,4,0,3,1,2]
```

Their 55 edges are pairwise distinct and cover every edge of `K11`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: eleven P6 copies partition E(K11)`.
