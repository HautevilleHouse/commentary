# Symmetry-Efficiency Subgroup-Restriction Proof

## Summary

Restricting a feasible equivariant bundle and section from a group to a
subgroup preserves feasibility and rank, so the subgroup optimum is no larger.
Run `./replay.sh` to validate the source-bound proof packet and its recorded
identity artifacts.

Source paper: Catalin Vasii, [From Gradient Descent to Harmonic
Interpolation: A Geometric Theory of Binary Classification](https://arxiv.org/abs/2607.00988v1).

Source object: OpenConjecture `4732`, arXiv `2607.00988v1`, Conjecture
`symmetry` in `paper1_final_v1.tex`, lines `1494-1502`. The definition used
by the claim is at lines `1474-1485`.

## Source Claim

Let `G_data` be a subgroup of `G`. For a continuous boundary `Gamma`, the
source defines `m*(K, epsilon)` to be the least rank of a `K`-equivariant
bundle and section whose zero set approximates `Gamma` within `epsilon`. It
conjectures

```text
m*(G_data, epsilon) <= m*(G, epsilon)
```

for every `epsilon > 0`.

## Proof

Fix `epsilon > 0` and a rank `m` feasible for `m*(G, epsilon)`. Thus there
are a rank-`m` `G`-bundle `E`, a representation `rho: G -> O(m)`, and a
`G`-equivariant section `s` with the prescribed Hausdorff-error bound.

Restrict the `G`-action on `E`, the representation `rho`, and the
equivariance identity to the subgroup `G_data`. For every `h in G_data`,

```text
s(h x) = rho(h) s(x),
```

so the same rank-`m` bundle and same section are feasible in the defining set
for `m*(G_data, epsilon)`. The zero set and its Hausdorff error have not
changed. Therefore every feasible rank for `G` is feasible for `G_data`, and
taking the least feasible rank yields

```text
m*(G_data, epsilon) <= m*(G, epsilon).
```

This proves the source claim as stated.

## Scope Boundary

The argument uses only the source definition: a `G`-equivariant section of a
rank-`m` `G`-bundle remains a `G_data`-equivariant section after subgroup
restriction. It does not address a different optimization problem in which
the smaller-group feasible class is restricted by extra conditions that are
not preserved under restriction. No such condition appears in the cited
definition.

## Files

- `PROOF.md` gives the definition-to-inclusion argument in a reusable form.
- `data/source_identity.json` records the exact source and content hashes.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limits.
- `data/verification_note.json` records the proof boundary and artifact hashes.
