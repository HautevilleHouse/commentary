# Graphical r-Stirling Monotonicity Resolution

Source paper: Daniel Yaqubi and Madjid Mirzavaziri,
[On the Graphical r-Stirling Numbers of the First Kind for Specific Graph Families](https://arxiv.org/abs/2602.02046v1).

Source object: OpenConjecture `746`, arXiv:`2602.02046v1`, Conjecture
`conj:r-monotone` in `YaqMirV1__1___2_.tex`, lines `1811-1818`.

The source displays a weakly decreasing chain for the graphical
`r`-Stirling numbers of the first kind, then describes that chain as strictly
decreasing. This packet proves the displayed weak chain, gives the exact gap
criterion, and disproves universal strictness with a positive-count example.

## Weak Monotonicity Theorem

Fix a graph `G` on the labeled vertex set `[n]` and a number of blocks `k`.
Let `P_k(G)` be the set of graphical cycle partitions of `G` into `k` blocks,
and define

```text
A_r = {pi in P_k(G) : vertices 1,...,r lie in distinct blocks}.
```

The restricted sets are nested:

```text
A_(r+1) subseteq A_r.
```

Indeed, if the first `r+1` vertices occupy distinct blocks, then the first `r`
vertices do as well. Taking cardinalities proves the displayed conjecture:

```text
[G k]_1 >= [G k]_2 >= ... >= [G k]_k.
```

More precisely,

```text
|A_r| - |A_(r+1)|
  = #{pi in A_r : vertex r+1 shares a block with some j in {1,...,r}}.
```

Because vertices `1,...,r` already occupy distinct blocks in `A_r`, such a
vertex `j` is unique when it exists. Consequently, the inequality at step `r`
is strict if and only if at least one such partition exists.

## Counterexample To Universal Strictness

Take the graph on vertices `{1,2,3}` with the single edge `{2,3}`, and set
`k=2`. Its only graphical cycle partition into two blocks is

```text
{{1}, {2,3}}.
```

It is counted for both `r=1` and `r=2`, since vertices `1` and `2` are in
different blocks. Therefore

```text
[G 2]_1 = 1 = [G 2]_2.
```

The example has positive counts and `k<n`, avoiding both an empty counting
class and the all-singleton boundary case.

## Replay

Run from the repository root:

```bash
python3 openconjectures/graphical-r-stirling-monotonicity/checkers/replay_monotonicity_resolution.py
```

The checker enumerates all set partitions of `{1,2,3}`, applies the source's
singleton/edge-block rules, and writes
`data/monotonicity_resolution_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/replay_monotonicity_resolution.py` verifies the exact witness.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/replay_receipt.json` records replay hashes and the claim boundary.

## Claim Boundary

- The displayed non-strict chain is proved under the source definition using
  the nested initial restricted sets `{1,...,r}`.
- The source's universal strict-decrease gloss is false; strictness for a
  particular graph, `k`, and step is governed by the gap criterion above.
- Other formulas and conjectures in arXiv:`2602.02046v1` are outside this
  packet.
- The included standard-library checker is the verification surface for this
  packet.
