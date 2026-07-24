# Catch-Up on `{1,2,3}`: finite replay

This packet checks the exact finite restriction `S={1,2,3}` of the Catch-Up
game formalized in the pinned [Formal Conjectures source](https://github.com/google-deepmind/formal-conjectures/blob/b8b5208aa5d01f5f91c49ca516bf09cae8d93693/FormalConjectures/Paper/CatchUpConjecture.lean).

The exact source evaluator gives `draw` under optimal play. Separate Python
and Ruby implementations return the same result.

This is a finite `S={1,2,3}` result only. It does not resolve the all-`N`
Catch-Up conjecture.

## Replay

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

Both commands print `draw`.
