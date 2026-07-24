# Lean-native replay

`Extended123.lean` formalizes the exact displayed-statement boundary for the
empty-set witness `A = ∅, n = 1`: every dilation is empty, the iterated
symmetric difference is empty, and its cardinality is not at least one. The
intended nonempty-set conjecture is not addressed.

Run from the packet root:

```sh
lean formal/Extended123.lean
python3 checkers/replay_counterexample.py
```

This is a bounded Lean-native replay using `Std`, not a Mathlib-backed proof.
