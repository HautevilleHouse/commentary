# Lean-native replay

`CatchUp123.lean` is the exact finite `{1,2,3}` source evaluator encoded as a
three-bit remaining set with explicit fuel. It proves the initial position is
a draw; the all-`N` conjecture remains outside scope.

The packet also includes a separately pinned Mathlib replay under
`formal/mathlib/`. Run the standalone Lean and Python/Ruby commands from the
packet root; run the Mathlib file in its pinned Mathlib checkout.
