# Stein Printed-Statement Obstruction

Source: arXiv:2602.13960v1, `Steady-State Behavior of Constant-Stepsize Stochastic Approximation: Gaussian Approximation and Tail Bounds`

Source object: OpenConjecture 368, `Arxiv_Version.tex` lines `797-804`, content hash `8fa484006e46772a0dfe0f837490517250dff46b5607ba87bf3254029dcf4c36`.

## Public Claim Boundary

This note publishes a Lean 4 formalization layer for the bounded OpenConjecture 368 printed-statement obstruction.

The encoded target checks that the absolute-value test function blocks the claimed classical `C^3` Stein solution as written: the operator side is differentiable at `0`, while the absolute-value side is not.

Repaired variants that change the test-function class, operator, or derivative notion remain carried outside this packet.

The source statement body is withheld. This packet identifies the source by arXiv id, source file, line range, and content hash.

## Replay

From this folder:

```bash
cd lean
cd openconjectures/stein-printed-statement-obstruction/lean && lake build SteinDisproof
```

The included build receipt records the checked local target build used for publication. The public folder is replayable through the included `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json`; build caches such as `.lake/` are not part of the repository.

## Files

- [Lean target](lean/SteinDisproof.lean)
- [Source identity](data/source_identity.json)
- [Build receipt](data/build_receipt.json)
- [Build log](data/lean_build_20260709.log)

## Carried Remainder

- Repaired Stein variants remain open.
- The source body text remains outside the public packet.
- The build checks the encoded Lean target; unrestricted source-level generalization remains outside this note's closure boundary.
