# Triangular Prism Domination-Packing Counterexample

Source paper: Juan Gutiérrez and Kaustav Paul,
[Improved Domination--Packing Bounds in Claw-Free Cubic Graphs and Unit Disk Graphs](https://arxiv.org/abs/2606.29199v1).

Source object: OpenConjecture `4867`, arXiv:`2606.29199v1`, Conjecture
`conj:cubic-75` in `intro.tex`, lines `76-81`, read with the domination and
packing definitions at line `7`.

## Source Claim

The conjecture states that every bridgeless claw-free cubic graph `G` satisfies

```text
gamma(G) <= (5/4) rho(G),
```

where `gamma(G)` is the minimum size of a dominating set and `rho(G)` is the
maximum size of a packing. The source defines a packing as a vertex set whose
distinct members are pairwise at distance at least `3`.

## Counterexample

Let `G` be the triangular prism. Label the vertices `0,1,2` on one triangle
and `3,4,5` on the other, with edge set

```text
01, 02, 12, 34, 35, 45, 03, 14, 25.
```

This graph belongs to the conjectured class:

- It is cubic: every vertex has degree `3`.
- It is bridgeless: every triangle edge lies on a triangle, and every matching
  edge lies on a four-cycle.
- It is claw-free: at each vertex, the two neighbors on the same triangle are
  adjacent, so its three neighbors cannot induce an independent set.

No single vertex dominates `G`, because every closed neighborhood has four of
the six vertices. The set `{0,3}` does dominate all six vertices. Therefore

```text
gamma(G) = 2.
```

The triangular prism has diameter `2`. Hence no two distinct vertices are at
distance at least `3`, while every singleton is a packing. Therefore

```text
rho(G) = 1.
```

Consequently

```text
gamma(G) = 2 > 5/4 = (5/4) rho(G),
```

which contradicts the universal conjecture.

## Replay

Run from the repository root:

```bash
python3 openconjectures/triangular-prism-domination-packing-counterexample/checkers/replay_counterexample.py
```

The standard-library checker verifies the graph class, enumerates every vertex
subset to compute `gamma(G)` and `rho(G)`, and checks both the conjectured bound
and the source's proved bound. It writes
`data/counterexample_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/replay_counterexample.py` verifies the graph and both invariants.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/replay_receipt.json` records replay hashes and the claim boundary.

## Claim Boundary

- The packet refutes the exact universal statement of Conjecture
  `conj:cubic-75` with a six-vertex graph in the stated class.
- The packet does not refute the source theorem
  `gamma(G) <= (7/4) rho(G) + 5/6`; the witness satisfies
  `2 <= 31/12`.
- The packet makes no claim about a repaired conjecture that excludes small
  graphs or adds another hypothesis.
- The packet makes no claim about the source's unit-disk-graph conjecture.
