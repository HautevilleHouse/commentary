# Ringel conjecture: bounded `n=2`, path `P3` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only the finite instance `n=2` with the 2-edge path `P3`. Five injective embeddings of `P3` into `Fin 5` are listed below; their edge sets partition all ten edges of `K5`:

```text
(0,2,1): {02,12}
(1,3,2): {13,23}
(2,4,3): {24,34}
(3,0,4): {03,04}
(4,1,0): {14,01}
```

The general Ringel conjecture remains open. This is a bounded verified replay, not a general resolution.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: five injective P3 copies partition E(K5)`.
