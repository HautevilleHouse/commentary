# Mathlib-environment replay

`DicePqrMathlib.lean` rechecks the exact finite certificate exported by
`lean/DicePqrCounterexample.lean` inside a separately pinned Mathlib
environment. This is an environment/closure replay, not a claim that the
large coefficient-list proof has been reconstructed with
Mathlib lemmas.

Verified with Mathlib `17b4b96c4eb874624e9cab005e966a25fd68ab14` and
`leanprover/lean4:v4.33.0-rc1` using `lake env lean` with the packet's `lean/`
directory on the import path.
