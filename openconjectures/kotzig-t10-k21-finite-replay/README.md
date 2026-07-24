# Kotzig finite slice: a 10-edge tree in (K_{21})

This packet settles only the bounded 10-edge instance. It makes no claim
about the general Kotzig conjecture.

Source material: `synthetic://kotzig-t10-cyclic-exact-20260720`, observed
2026-07-20, SHA-256
`10a1d080b8eff95108b6b3db56dad945ab9467c9a05f9c2428082155277164f8`.

Base labels are `[0,9,8,10,3,18,13,17,20,1,2]`. The ten edge lengths are
exactly `1..10` modulo 21, so the 21 shifts partition K21.

Replay:

```sh
python3 math_research/checkers/kotzig_t10_k21_checker.py
ruby math_research/checkers/kotzig_t10_k21_checker.rb
```

Delegation receipt: `results/kotzig_t10_k21_delegated_replay_20260722.json`
