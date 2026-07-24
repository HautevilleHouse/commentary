# Kotzig finite slice: an 11-edge tree in (K_{23})

This packet settles only the bounded 11-edge instance. It makes no claim
about the general Kotzig conjecture.

Source material: `synthetic://kotzig-t11-cyclic-exact-20260720`, observed
2026-07-20, SHA-256
`4ad4e023e3d0b3893532133fcbef6aa199ba782202039559082dedb53d8d73f4`.

Base labels in tree-vertex order are `[0,1,2,3,7,12,18,11,19,5,15,4]`.
The 11 tree-edge lengths are exactly 1 through 11 modulo 23, so the 23
cyclic shifts partition all 253 edges of `K23`.

Replay:

```sh
python3 math_research/checkers/kotzig_t11_k23_checker.py
ruby math_research/checkers/kotzig_t11_k23_checker.rb
```

Delegation receipt: `results/kotzig_t11_k23_delegated_replay_20260722.json`
