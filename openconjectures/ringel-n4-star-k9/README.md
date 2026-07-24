# Ringel conjecture: bounded `n=4`, star `K1,4` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=4` for the 4-edge star `K1,4` in `K9`. Each tuple is `(center, leaf1, leaf2, leaf3, leaf4)`:

```text
(0,1,2,3,4), (1,2,3,4,5), (2,3,4,5,6), (3,4,5,6,7),
(4,5,6,7,8), (5,6,7,8,0), (6,7,8,0,1), (7,8,0,1,2), (8,0,1,2,3)
```

The nine stars have 36 pairwise distinct edges and cover every edge of `K9`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: nine K1,4 copies partition E(K9)`.
