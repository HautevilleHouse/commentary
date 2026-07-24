# Ringel finite slice: both 3-edge trees in (K_7)

This packet settles the complete (n=3) finite slice: the path (P_4) and
the star (K_{1,3}). It makes no claim about other trees or general (n).

Source material: `synthetic://ringel-n3-k7-two-trees-exact-20260720`, observed
2026-07-20, SHA-256
`4221ef048b80614fb9fd0a67632fefaaf858470ee29633d2ff14bc583b40a68d`.

The path embeddings are cyclic shifts of `[0,1,3,6]`; the star embeddings
use center `i` and leaves `i+1,i+2,i+3` modulo 7. Each family has 21 distinct
edges and covers `K7` exactly.

Replay:

```sh
python3 math_research/checkers/ringel_n3_k7_two_trees_checker.py
ruby math_research/checkers/ringel_n3_k7_two_trees_checker.rb
```

Delegation receipt: `results/ringel_n3_k7_two_trees_delegated_replay_20260722.json`
