# Formal replay

`Goemans.lean` is a Lean 4.31.0 proof of the finite table claim: all eight
route choices fail the conjunction of the source capacity and cost conditions.
It uses the standard Lean distribution (`Std`).

Replay:

```bash
lean formal/Goemans.lean
```

The theorem is finite and instance-specific. The Python and Ruby checkers remain
the separately implemented graph-level replays.
