# Kotzig finite slice: an 8-edge tree in (K_{17})

This packet settles only the bounded 8-edge instance. It makes no claim
about the general Kotzig conjecture.

Source material: `synthetic://kotzig-t8-cyclic-exact-20260720`, observed
2026-07-20, SHA-256
`67f4cf718279774d48da01ff102d1fd78db72ee3c66f1fae8bf4fea969d3df7f`.

Base labels in tree-vertex order are `[0,8,7,6,1,5,2,4,3]`.
The eight tree-edge lengths are exactly 1 through 8 modulo 17, so the 17
cyclic shifts partition all 136 edges of `K17`.

Replay:

```sh
python3 math_research/checkers/kotzig_t8_k17_checker.py
ruby math_research/checkers/kotzig_t8_k17_checker.rb
```

Delegation receipt: `results/kotzig_t8_k17_delegated_replay_20260722.json`
