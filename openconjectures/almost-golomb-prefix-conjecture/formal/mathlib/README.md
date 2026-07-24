# Pinned Mathlib replay

This directory rechecks the packet's Lean lemmas in a separately pinned
Mathlib environment.  The source packet is imported unchanged; the wrapper
theorems expose the same obligations under a distinct namespace.

Pinned source: Mathlib `v4.28.0` (the packet's `lean/lean-toolchain` and
`lakefile.lean`).  Run `lake env lean formal/mathlib/AlmostGolombPrefixMathlib.lean`
from a clean checkout after fetching the pinned dependency.
