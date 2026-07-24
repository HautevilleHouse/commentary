# Ringel conjecture: bounded `n=9`, path `P10` slice

Source: [Formal Conjectures `RingelConjecture.lean`](https://github.com/google-deepmind/formal-conjectures/blob/6f57f58effb32da91a5761c1a5491904a85921ab/FormalConjectures/Paper/RingelConjecture.lean), commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20.

This packet settles only `n=9` for the 9-edge path `P10` in `K19`. Use the base embedding `[0,9,10,18,1,8,11,17,2,7]` and its 19 cyclic shifts modulo 19. The nine edge differences are `9,1,8,2,7,3,6,4,5`, giving exact coverage of all 171 edges of `K19`. The general Ringel conjecture remains open.

## Replay

```sh
python3 verify.py
```

Expected output: `PASS: nineteen P10 copies partition E(K19)`.
