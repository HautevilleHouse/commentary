# CRIM Rectair Boundary Counterexample

Source paper: Ina Bašić, Eric Gottlieb, and Matjaž Krnc,
[CRIM: A Natural Game on Integer Partitions](https://arxiv.org/abs/2606.16828v1).

Source object: OpenConjecture `3659`, arXiv:`2606.16828v1`, the first rectair
Sprague-Grundy conjecture in `arXiv.tex`, lines `1021-1030`.

## Printed Claim

For integers `0 <= k < r`, the source proposes

```text
G(R^k_(r,r)) = 0  if r is even or k < r-1;
                 1  if r is 3 or 5, r is odd, and k=r-1;
                 2  otherwise.
```

## Counterexample

Take

```text
r=1, k=0.
```

This pair satisfies the printed domain condition `0 <= k < r`. By the source
definition of a rectair,

```text
R^0_(1,1) = [1].
```

The one-cell partition has a single distinct CRIM option: deleting its row or
its column reaches the empty partition. Since the empty partition has
Sprague-Grundy value `0`,

```text
G([1]) = mex({0}) = 1.
```

For `r=1,k=0`, the first printed branch fails because `r` is odd and `0 < 0`
fails. The second branch applies only to `r in {3,5}`. The printed otherwise
branch therefore assigns `2`, contradicting the direct value `1`.

The source later identifies `R^0_(1,1)` with the staircase `S_1` and separately
assigns `G(S_1)=1`, providing a source-internal confirmation of the direct game
calculation.

Thus the conjecture is false on its printed domain. Restricting its domain to
`r >= 2` removes this counterexample; the resulting all-`r>=2` formula remains
outside this packet.

## Replay

Run from the repository root:

```bash
python3 openconjectures/crim-rectair-boundary-counterexample/checkers/replay_counterexample.py
```

The standard-library checker reconstructs CRIM row and column moves, computes
the exact mex value, verifies the printed branch selection, and scans all
square rectairs with `1 <= r <= 9`. It writes
`data/counterexample_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/replay_counterexample.py` verifies the exact game calculation.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/replay_receipt.json` records replay hashes and the claim boundary.

## Claim Boundary

- The packet disproves the source formula on its printed `0 <= k < r` domain.
- The exact witness is `R^0_(1,1)=[1]`, with actual value `1` and printed value
  `2`.
- The domain repair `r >= 2` removes this witness; the repaired formula and
  the source's other CRIM conjectures remain open here.
