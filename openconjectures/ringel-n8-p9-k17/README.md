# Ringel conjecture: bounded `n=8`, path `P9` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=8` for the 8-edge path `P9` in `K17`. Use the base embedding `[0,8,1,7,2,6,3,5,4]` and its 17 cyclic shifts modulo 17. Consecutive differences have absolute residues `8,7,6,5,4,3,2,1`, so the 136 edges are pairwise distinct and cover every edge of `K17`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: seventeen P9 copies partition E(K17)`.
