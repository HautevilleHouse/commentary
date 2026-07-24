# Strong Sensitivity: finite `n=3` replay

This packet checks the `n=3` restriction of the Strong Sensitivity Conjecture
from the pinned Formal Conjectures source. For every Boolean function on three
bits (all 256 truth tables), it computes block sensitivity `bs(f)` and ordinary
sensitivity `s(f)` and verifies `bs(f) ≤ s(f)^2`.

Both implementations enumerate all 256 functions and return the
same distribution: `(bs,s) = (0,0): 2`, `(1,1): 6`, `(2,2): 110`, and
`(3,3): 138`.

This is a finite internally verified result only. The general conjecture
remains open.

## Replay

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

Both commands print `256 2 6 110 138`.

Source: [Formal Conjectures, pinned commit](https://github.com/google-deepmind/formal-conjectures/blob/b8b5208aa5d01f5f91c49ca516bf09cae8d93693/FormalConjectures/Paper/StrongSensitivityConjecture.lean)
