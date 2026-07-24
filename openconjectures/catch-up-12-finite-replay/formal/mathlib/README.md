# Mathlib-backed replay

This is the same finite `{1,2}` evaluator as `formal/CatchUp12.lean`, checked
in a separately pinned Mathlib environment. It proves the initial position is
a win and the response position after taking `2` is a loss. The general
Catch-Up conjecture remains outside scope.

The file was checked with Mathlib `17b4b96c4eb874624e9cab005e966a25fd68ab14`
(`leanprover/lean4:v4.33.0-rc1`) using `lake env lean`.
