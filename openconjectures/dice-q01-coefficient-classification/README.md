# Coefficient Classification for \(Q_{01}\)

This source-bound note proves Conjecture 5.7 of Fiore, Nasr, and Stone,
*Dice Relabeling Using Square-Sided Dice*, arXiv:2606.20311v1.

## Result

For distinct primes `p` and `q`, the polynomial

```text
Q_01(x) = x Phi_q(x)^2 Phi_(p^2 q)(x)
```

has nonnegative coefficients exactly when `p = 2` and `q` is congruent to
`1` modulo `4`.

The proof treats `p = 2` by an exact parity recurrence. For odd `p`, two
low-degree cases produce an explicit coefficient `-1`; the remaining range
uses a periodized triangular sequence modulo `p^2` and forces a negative
cyclic difference.

## Source

- [Abstract and version history](https://arxiv.org/abs/2606.20311v1)
- [HTML rendering](https://arxiv.org/html/2606.20311v1)
- [TeX source](https://arxiv.org/src/2606.20311v1)

The source archive and TeX payload hashes are recorded in
`data/source_identity.json`.

## Start here

- [`PROOF.md`](PROOF.md): the arbitrary-parameter proof.
- [`checkers/verify.py`](checkers/verify.py): closed-form, cyclic-witness, and
  separate cyclotomic checks.
- [`data/replay_receipt.json`](data/replay_receipt.json): file hashes and the
  replay command.
- [`data/prior_public_resolution_search_20260718.json`](data/prior_public_resolution_search_20260718.json):
  the dated bounded public-resolution search.

Replay with Python 3 and no third-party packages:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 checkers/verify.py
```

The output should be one deterministic JSON object with `"all_pass":true`.

## Claim boundary

The closed object is Conjecture 5.7 exactly as printed in
arXiv:2606.20311v1. The classification of square-sided dice remains governed by
the definitions and other open cases in the source paper.

## Rights

Copyright © 2026 Hauteville House. All Rights Reserved - No License Granted.

Citation is required for public reference, discussion, comparison,
implementation, derivative research use, or review. No patent license is
granted by this packet.
