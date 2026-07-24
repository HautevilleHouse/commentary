# Ringel finite slice: (P_7) in (K_{13})

This packet settles only the (n=6) path slice. It makes no claim about
other trees or general (n).

Source material: `synthetic://ringel-n6-k13-p7-exact-20260720`, observed
2026-07-20, SHA-256
`a5274c8060f61eed112d13944bebea6764ebaa3178d9a418d93dab4181c4e577`.

Witness: take the thirteen cyclic shifts modulo 13 of the path
`[0,1,3,6,10,2,8]`. Their 78 path edges are pairwise distinct and cover all
edges of `K13`.

Replay:

```sh
python3 math_research/checkers/ringel_n6_k13_p7_checker.py
ruby math_research/checkers/ringel_n6_k13_p7_checker.rb
```

Delegation receipt: `results/ringel_n6_k13_p7_delegated_replay_20260722.json`
