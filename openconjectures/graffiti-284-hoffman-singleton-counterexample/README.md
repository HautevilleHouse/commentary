# Graffiti 284 Hoffman–Singleton counterexample

This source-bound note records an algebraic counterexample to the usual
Written-on-the-Wall reading of Graffiti conjecture 284:

```text
for connected simple graphs of girth at least 5,
min_dual ≤ -λ_min(D),
```

where `min_dual` is the minimum dual degree and `D` is the distance matrix.

The Hoffman–Singleton graph is 7-regular of girth 5 and diameter 2, with
adjacency spectrum `{7^1, 2^28, (-3)^21}`.  Dual degree is identically 7, and
the diameter-2 identity `D = 2(J - I) - A` forces

```text
Spec(D) = {91^1, 1^21, (-4)^28},
```

so `λ_min(D) = -4`.  The conjecture would therefore require `7 ≤ 4`, which is
false with margin 3.

## Source

- Graffiti / Written on the Wall numbering for conjecture 284
  (Fajtlowicz; dual-degree vs least distance eigenvalue; girth ≥ 5)
- [Aouchiche–Hansen spectral Graffiti survey context](https://gerad.ca/fr/papers/G-2009-18)
- [Roucairol–Cazenave search table still listing 284 as open at n ≤ 50](https://www.lamsade.dauphine.fr/~cazenave/papers/ConjectureRefutationECAI2025.pdf)
- [Hoffman–Singleton parameters at DistanceRegular.org](https://www.math.mun.ca/distanceregular/graphs/hoffmansingleton.html)
- [Rowlinson–Sciriha adjacency spectrum `7^1, 2^28, (-3)^21`](https://doi.org/10.2298/AADM0702438R)

Exact locator hashes and claim boundaries are recorded in
`data/source_identity.json`.

## Start here

- [`PROOF.md`](PROOF.md): the diameter-2 spectral bridge and numerical
  contradiction.
- [`checkers/verify.py`](checkers/verify.py): algebraic dual-checker,
  with Petersen as a tight non-counterexample control.
- [`lean/Graffiti284HoffmanSingletonCounterexample.lean`](lean/Graffiti284HoffmanSingletonCounterexample.lean):
  Lean Lake certificate (stdlib-only, `lake build`) for the spectral bridge and `¬ (7 ≤ 4)`.
- [`data/replay_receipt.json`](data/replay_receipt.json): sealed file hashes and
  replay commands.
- [`data/prior_public_resolution_search_20260723.json`](data/prior_public_resolution_search_20260723.json):
  the dated, bounded public-resolution search.

Replay with:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 checkers/verify.py
cd lean && lake build
```

## Claim boundary

This packet closes only the numerical reading above under the recorded
Hoffman–Singleton spectral facts and the diameter-2 identity.  It does **not**
construct Hoffman–Singleton inside Lean, does **not** claim a peer-reviewed
journal settlement, and does **not** treat informal public announcements as a
finished formal kill by themselves.  Public statement proxies (Roucairol
computational pin, mewc algebraic writeup, ECAI 2025 search-table PDF) are
sealed under [`data/source_seals/manifest.json`](data/source_seals/manifest.json).
The Fajtlowicz Written-on-the-Wall master list remains an external remainder:
it is available by request and no public primary page printing the exact
wording of conjecture 284 was fetchable.

## Rights

Copyright © 2026 Hauteville House. All Rights Reserved - No License Granted.

Citation is required for public reference, discussion, comparison,
implementation, derivative research use, or review. No patent license is
granted by this packet.
