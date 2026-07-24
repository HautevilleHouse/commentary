# Ringel conjecture: bounded `n=3`, star `K1,3` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=3` for the 3-edge star `K1,3` in `K7`. Each tuple is `(center, leaf1, leaf2, leaf3)`:

```text
(0,1,2,4), (1,2,3,5), (2,3,4,6), (3,4,5,0),
(4,5,6,1), (5,6,0,2), (6,0,1,3)
```

The seven stars have 21 pairwise distinct edges and cover every edge of `K7`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: seven K1,3 copies partition E(K7)`.
