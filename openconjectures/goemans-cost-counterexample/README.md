# Finite Goemans cost-conjecture counterexample

This packet records a finite counterexample to Goemans' cost-enhanced single-source unsplittable-flow conjecture (Conjecture 1.3 in [arXiv:2308.02651](https://arxiv.org/abs/2308.02651)). It addresses only the displayed seven-vertex acyclic instance; it does not claim a general theorem about all SSUF instances.

The fractional flow has cost 58. Exhaustive enumeration of all eight path selections shows that every selection satisfying `flow <= x + d_max` has cost 60 or 90, while every selection of cost at most 58 violates a capacity bound. Thus no unsplittable flow satisfies both source conditions for this instance.

## Replay

From a clean clone, run:

```bash
python3 checkers/dgg_goemans_counterexample_replay.py
ruby checkers/dgg_goemans_counterexample_replay.rb
```

Both checkers enumerate all eight routings and must report four capacity-good routings (costs 60, 60, 60, 90) and four capacity-violating routings.

## Provenance and review

- Source statement: [arXiv:2308.02651v1](https://arxiv.org/abs/2308.02651), observed 2026-07-22.
- Supplied witness PDF SHA-256: `b025cdcfae7519353b2f716b76d31b8901a488a471e2df06e0601a944b10e702`.
- Machine-readable instance SHA-256: `1dadbeba30faff13259e302ed8e1e72a75e165b8ae4c043a7593b99cb71ae1ee`.
- Python/Ruby replay: pass.
- Lean 4.31.0 finite replay: pass (`formal/Goemans.lean`).
- Delegated review: returned `VALID_COUNTEREXAMPLE`; the handoff remains untrusted and is included as a receipt for reproducibility.

The result is finite and instance-specific. The general Goemans conjecture remains an open question outside this counterexample's scope.
