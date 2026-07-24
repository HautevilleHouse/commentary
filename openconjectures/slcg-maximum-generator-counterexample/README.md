# Counterexample to the S-LCG Maximum-Generator Formula

This source-bound note disproves the Maximum Generator conjecture in
Mohammed, Banka, and Singh, *S-LCG: Structured Linear Congruential
Generator-Based Deterministic Algorithm for Search and Optimization*,
arXiv:2605.05198v1.

## Result

For `n = 7`, the S-LCG map is

```text
f(x) = 2x + 1 mod 129.
```

It has the two-cycle `42 -> 85 -> 42`.  Under the source definition, a
cycle's generator is its minimum element, so `42` is a generator and the
maximum generator is at least `42`.  The conjectured closed form and printed
recurrence both give `20` at `n = 7`.  Therefore the conjecture is false.

The proof also gives the same obstruction for every odd `n >= 3`: the
two-cycle

```text
a_n = (2^n - 2) / 3,
b_n = (2^(n+1) - 1) / 3
```

has generator `a_n`, which is larger than the conjectured value.

## Source

- [OpenConjecture problem 2378](https://openconjecture.org/problems/2378)
- [arXiv abstract and version history](https://arxiv.org/abs/2605.05198v1)
- [arXiv TeX source](https://arxiv.org/src/2605.05198v1)

The exact source archive and TeX hashes are recorded in
`data/source_identity.json`.

## Start here

- [`PROOF.md`](PROOF.md): the finite counterexample and infinite witness
  family.
- [`checkers/verify.py`](checkers/verify.py): direct arithmetic and exhaustive
  cycle-partition replay.
- [`lean/SLCGMaximumGeneratorCounterexample.lean`](lean/SLCGMaximumGeneratorCounterexample.lean):
  the Lean/mathlib certificate for the `n = 7` counterexample.
- [`data/replay_receipt.json`](data/replay_receipt.json): sealed file hashes and
  replay commands.
- [`data/prior_public_resolution_search_20260718.json`](data/prior_public_resolution_search_20260718.json):
  the dated, bounded public-resolution search.

Replay with:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 checkers/verify.py
cd lean && lake build
```

## Claim boundary

This packet refutes the source's printed Maximum Generator conjecture using
the source's own recurrence, modulus, and cycle-minimum definition.  It does
not assess the paper's benchmark results, the quality of the optimization
method, or a repaired generator-space definition that excludes short cycles.

## Rights

Copyright © 2026 Hauteville House. All Rights Reserved - No License Granted.

Citation is required for public reference, discussion, comparison,
implementation, derivative research use, or review. No patent license is
granted by this packet.
