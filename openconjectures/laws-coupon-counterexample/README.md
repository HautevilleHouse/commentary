# LAWS Coupon Counterexample

Source object: OpenConjecture `2421`, arXiv:`2605.04069v1`, `LAWS.tex`
lines `1812-1832`.

This packet gives a source-worded counterexample to the printed
expert-creation lower-bound wording in the LAWS convergence-rate conjecture.

## Public Claim Boundary

The printed claim measures acquisition cost in expert creations. The
coupon-collector calculation controls query time until all equal-probability
heavy nodes are discovered.

There is a literal online strategy with expert creations equal to `0`. Even
under the natural first-hit cache model, with `m = 2^H` uniform heavy nodes, the
expected number of experts created by query `N` is

```text
E[C_N] = m * (1 - (1 - 1/m)^N) <= m = 2^H.
```

Therefore

```text
E[C_N] / (2^H log N) <= 1 / log N -> 0.
```

That contradicts a lower bound of order `2^H log N` for expert creations.

## Repaired Route

The coupon-collector theorem supports a query-time statement instead:

```text
E[T_all] = m H_m = Theta(m log m) = Theta(2^H H)
```

for the expected number of queries needed to discover all `m = 2^H` equally
likely heavy nodes. That is a different target from expert-creation acquisition
cost.

## Replay

Run from the repository root:

```bash
python3 openconjectures/laws-coupon-counterexample/checkers/replay_coupon_counterexample.py
```

The checker writes `data/coupon_counterexample_check_20260709.json`.

## Files

- `data/source_identity.json` records the public source identity and source
  hashes.
- `checkers/replay_coupon_counterexample.py` emits the deterministic witness
  calculation.
- `data/replay_receipt.json` records the replay command, hashes, and carried
  boundary.

## Carried Boundary

- The corrected query-time coupon-collector theorem is separate from this
  counterexample packet.
- Other LAWS conjectures remain outside this packet.
- This packet is a public checker packet rather than a Lean formalization.
