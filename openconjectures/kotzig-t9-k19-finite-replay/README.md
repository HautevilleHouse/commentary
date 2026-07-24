# Kotzig finite slice: a 9-edge tree in (K_{19})

This packet settles only the bounded 9-edge instance. It makes no claim
about the general Kotzig conjecture.

Source material: `synthetic://kotzig-t9-cyclic-exact-20260720`, observed
2026-07-20, SHA-256
`03a7d983f61f03815645322b1d67c4b73edb646c6dd18cf2d9f47be48381d6bd`.

Base labels in tree-vertex order are `[0,1,2,3,18,13,7,14,6,15]`.
The nine tree-edge lengths are exactly 1 through 9 modulo 19, so the 19
cyclic shifts partition all 171 edges of `K19`.

Replay:

```sh
python3 math_research/checkers/kotzig_t9_k19_checker.py
ruby math_research/checkers/kotzig_t9_k19_checker.rb
```

Delegation receipt: `results/kotzig_t9_k19_delegated_replay_20260722.json`
