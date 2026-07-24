# Mathlib-backed replay

This repeats the exact fifteen-path partition of `K15` in a separately pinned
Mathlib environment and checks path validity, edge distinctness, and finite
edge-membership equality.

Verified with Mathlib `17b4b96c4eb874624e9cab005e966a25fd68ab14` and
`leanprover/lean4:v4.33.0-rc1` using `lake env lean`.
