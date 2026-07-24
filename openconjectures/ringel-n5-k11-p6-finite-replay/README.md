# Ringel finite slice: (P_6) in (K_{11})

This packet settles only the (n=5) path slice. It makes no claim about
other trees or general (n).

Source material: `synthetic://ringel-n5-k11-p6-exact-20260720`, observed
2026-07-20, SHA-256
`35f3d4093f863987969c9b7b2b2451774acddd67f4df3df53d236fd15b03fecf`.

Witness: take the eleven cyclic shifts modulo 11 of the path
`[0,5,1,4,2,3]`. Their 55 path edges are pairwise distinct and cover all
edges of `K11`.

Replay:

```sh
python3 math_research/checkers/ringel_n5_k11_p6_checker.py
ruby math_research/checkers/ringel_n5_k11_p6_checker.rb
```

Delegation receipt: `results/ringel_n5_k11_p6_delegated_replay_20260722.json`
