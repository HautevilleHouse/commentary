# Odd-Cycle Cyclic-Interval Proof

## Summary

The packet proves the displayed odd-cycle cyclic-interval bound by averaging
intervals and checks the finite instances recorded by the source. Run
`./replay.sh` to regenerate the verification record.

Source paper: Fokam Souop Rigobert and Bitjoka Laurent,
[Dimension and Order Bounds for Isometric Embeddings of Graphs into Abelian Cayley Graphs, and the Abelian Dividend](https://arxiv.org/abs/2607.07939v1).

Source object: OpenConjecture `4448`, arXiv:`2607.07939v1`, Conjecture 1
in `paper2_revision_1.tex`, lines `407-410`, using the cyclic interval lemma
at lines `374-379` and the reduction at lines `390-404`.

## Source Claim

Let `m` be odd and let `x` be a nonempty proper subset of the cyclic group
`Z_m`. The source asks whether there is always a cyclic arc `W` such that

```text
|W symmetric-difference x| < min(|W|, m-|W|).
```

It verifies this through `m=17` and explains that the general lemma implies
that the minimum binary dimension of every odd cycle `C_m` is `m-1`.

## Proof

Write `m=2d+1`. Arc complements are arcs, and simultaneous complementation
of `W` and `x` preserves both sides of the desired inequality. We may
therefore assume

```text
w := |x| <= d.
```

For a fixed length `L`, consider all `m` cyclic arcs of length `L`. Every
point of `Z_m` belongs to exactly `L` of them, so

```text
sum_W |W intersect x| = Lw.
```

There are two parity cases.

### Odd `w`

Take `L=d`. The average intersection size is `dw/m`, and

```text
dw/m - (w-1)/2 = (m-w)/(2m) > 0.
```

Hence some length-`d` arc `W` has

```text
|W intersect x| >= (w+1)/2.
```

For that arc,

```text
|W symmetric-difference x|
  = d+w-2|W intersect x|
  <= d-1
  < d
  = min(|W|,m-|W|).
```

### Even `w`

Take `L=d+1`. The average intersection size is `(d+1)w/m`, and

```text
(d+1)w/m - w/2 = w/(2m) > 0.
```

Thus some length-`d+1` arc `W` has

```text
|W intersect x| >= w/2+1.
```

Consequently,

```text
|W symmetric-difference x|
  = d+1+w-2|W intersect x|
  <= d-1
  < d
  = min(|W|,m-|W|).
```

This proves the cyclic interval lemma for every odd `m`.

## Odd-Cycle Consequence

For completeness, the source reduction can be summarized directly. In a
binary isometric labeling of `C_m`, let the `m` edge generators be `s_i` and
let `D` be their dependency code. The all-ones word lies in `D` because the
edge generators sum to zero around the cycle. If their rank were at most
`m-2`, then `D` would contain another nontrivial word `x`.

The lemma supplies an arc `W` for which `W symmetric-difference x` uses fewer
generators than the graph distance between the endpoints of `W`. Since `x`
is a dependency, the two subsets of generators have the same sum. This gives
a path in the binary host shorter than the cycle distance, contradicting
isometry. Therefore the edge-generator rank is at least `m-1`. The standard
cycle construction has dimension `m-1`, so

```text
k_min(C_m) = m-1
```

for every odd `m`.

## Verification

Run from the repository root:

```bash
python3 openconjectures/odd-cycle-cyclic-interval-proof/checkers/verify_cyclic_interval.py
```

The standard-library checker validates the two averaging inequalities over a
large finite parameter grid and exhaustively checks every nonempty proper
subset of every odd cycle through `m=19`. It writes
`data/cyclic_interval_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/verify_cyclic_interval.py` checks the proof inequalities and
  finite instances without relying on the source computation.
- `data/cyclic_interval_check_20260717.json` records the checker result.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/verification_receipt.json` records checker hashes and the claim
  boundary.

## Claim Boundary

- The proof establishes the exact cyclic interval lemma for every odd `m`.
- Together with the source's dependency-code reduction and upper-bound
  construction, it establishes `k_min(C_m)=m-1` for every odd cycle.
- The executable checker is finite corroboration of the general proof, not
  the basis for its universal quantifier.
- The packet makes no claim about minimum abelian host order or graph
  families other than odd cycles.
