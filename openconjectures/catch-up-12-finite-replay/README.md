# Catch-Up on `{1,2}`: finite replay

This packet checks the exact finite restriction `S={1,2}` of the Catch-Up game
formalized in the pinned [Formal Conjectures source](https://github.com/google-deepmind/formal-conjectures/blob/b8b5208aa5d01f5f91c49ca516bf09cae8d93693/FormalConjectures/Paper/CatchUpConjecture.lean).

Using the source evaluator and optimal play, the first player wins by choosing
`2`. The remaining `1` cannot let the opponent catch up, so the opponent loses.
Separate Python and Ruby implementations both return `win`.

This is a finite `S={1,2}` result only. It does not resolve the all-`N`
Catch-Up conjecture.

## Replay

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

Both commands print `win`.
