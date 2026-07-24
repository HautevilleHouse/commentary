# General SGD Moment Disproof

Source: arXiv:2602.13960v1, `Steady-State Behavior of Constant-Stepsize Stochastic Approximation: Gaussian Approximation and Tail Bounds`

Source object: OpenConjecture 367, `Arxiv_Version.tex` lines `792-794`, content hash `be1cee092961964276619d9696224da5e1692068d9798e474e535936f43fef58`.

## Public Claim Boundary

This note publishes a Lean 4 formalization layer for the bounded OpenConjecture 367 packet.

The encoded target checks two packet-scope routes:

- a literal printed-statement disproof using deterministic non-centered noise on a one-point probability space;
- a repaired-centered `h = 2` heavy-tail AR(1) route showing the relevant higher-moment conclusion fails for the encoded specialization.

Broader repaired SGD statement families remain carried outside this packet.

The source statement body is withheld. This packet identifies the source by arXiv id, source file, line range, and content hash.

## Replay

From this folder:

```bash
cd lean
cd openconjectures/general-sgd-moment-disproof/lean && lake build GeneralSGDMomentDisproof
```

The included build receipt records the checked local target build used for publication. The public folder is replayable through the included `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json`; build caches such as `.lake/` are not part of the repository.

## Files

- [Lean target](lean/GeneralSGDMomentDisproof.lean)
- [Source identity](data/source_identity.json)
- [Build receipt](data/build_receipt.json)
- [Build log](data/lean_build_20260709.log)

## Carried Remainder

- Broader repaired SGD variants remain open.
- The source body text remains outside the public packet.
- The build checks the encoded Lean target; unrestricted source-level generalization remains outside this note's closure boundary.
