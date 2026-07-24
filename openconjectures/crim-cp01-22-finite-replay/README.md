# CRIM finite replay: partition ([2,2])

This packet settles only the explicit non-hook partition `[2,2]` in the
source game. It makes no claim about the general CRIM classification.

Source material: `synthetic://crim-cp01-full-exact-20260720`, observed
2026-07-20, SHA-256
`c8daeac2b5ac66b0f3d670645c68fb43ea88ffbd76e9422068e1be5e760f9ce1`.

The reachable state table is `[] -> [2] -> [2,2]`. With the source base
values (G(\emptyset)=0,H(\emptyset)=1), mex gives
`G([2])=1, H([2])=0`, then `G([2,2])=0, H([2,2])=1`.

Replay:

```sh
python3 math_research/checkers/crim_cp01_22_checker.py
ruby math_research/checkers/crim_cp01_22_checker.rb
```

Delegation receipt: `results/crim_cp01_22_delegated_replay_20260722.json`
