# Mathlib-backed replay

This file repeats the exact empty-set witness in a separately pinned Mathlib
environment. It proves that every dilation and the displayed symmetric
difference are empty, so the printed `n=1` inequality fails. The intended
nonempty-set conjecture remains outside scope.

Verified with Mathlib `17b4b96c4eb874624e9cab005e966a25fd68ab14` and
`leanprover/lean4:v4.33.0-rc1` using `lake env lean`.
