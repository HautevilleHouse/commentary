# Hilbert-Depth Product Inequalities

This source-bound note proves all four inequalities in Conjecture 4.1 of
Bordianu and Cimpoeaş, *On the Hilbert depth of the quotient ring of the edge
ideal of a complete bipartite graph*, arXiv:2602.09607v1.

## Result

For every positive integer `s`, each product in Conjecture 4.1(a)-(d) is
strictly smaller than `2` whenever `k` satisfies the corresponding lower bound
printed in the source.

The proof rewrites each product as paired factors, applies a convex midpoint
bound to a sum of inverse hyperbolic tangents, and controls the remaining power
series by exact rational estimates derived from `log(2) < 7/10`.

## Source

- [Abstract and version history](https://arxiv.org/abs/2602.09607v1)
- [HTML rendering](https://arxiv.org/html/2602.09607v1)
- [TeX source](https://arxiv.org/src/2602.09607v1)

The source archive SHA-256 is recorded in `data/source_identity.json`.

## Start here

- [`PROOF.md`](PROOF.md): the all-parameter argument.
- [`checkers/verify.py`](checkers/verify.py): exact algebraic and rational
  checks plus bounded high-precision source instances.
- [`data/replay_receipt.json`](data/replay_receipt.json): file hashes and the
  replay command.
- [`data/prior_public_resolution_search_20260718.json`](data/prior_public_resolution_search_20260718.json):
  the bounded public-resolution search record.

Replay with Python 3 and no third-party packages:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 checkers/verify.py
```

The output should be one deterministic JSON object with `"all_pass":true`.

## Claim boundary

The closed object is Conjecture 4.1(a)-(d) exactly as printed in
arXiv:2602.09607v1. Proposition 4.2 and the wider Hilbert-depth development
remain governed by the definitions and reductions in the source paper.

## Rights

Copyright © 2026 Hauteville House. All Rights Reserved - No License Granted.

Citation is required for public reference, discussion, comparison,
implementation, derivative research use, or review. No patent license is
granted by this packet.
