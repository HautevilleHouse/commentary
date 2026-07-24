# Lean-native replay

`CatchUp12.lean` implements the source evaluator for the exact finite set
`S={1,2}` using a two-bit remaining-set encoding and an explicit finite fuel
bound. It proves that the initial position is a win and that the first move
of taking `2` leaves a losing position for the opponent. The all-`N`
conjecture remains outside scope.

Run from the packet root:

```sh
lean formal/CatchUp12.lean
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

The packet carries both the standalone Lean replay and a separately pinned
Mathlib-backed replay under `formal/mathlib/`.
