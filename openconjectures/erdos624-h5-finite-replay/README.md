# Erdős 624: finite `H(5)=3` replay

This packet settles only the finite five-color slice of the powerset-covering
function in Erdős Problem 624. It does not settle the asymptotic conjecture.

The packet contains an explicit 32-entry truth table. Every target set of
size 3, 4, or 5 sees all five colors, while a target of size 2 has only four
subsets, so `m<=2` is impossible.

## Replays

```sh
python3 checkers/verify_h5.py
ruby checkers/verify_h5.rb
```

Both implementations must report `H(5)=3` and successful coverage for every
target of size at least 3. Source hashes, the exact bounded statement, and
the claim boundary are recorded in `source/source_exact_statement.txt` and
`result.json`. DeepSeek dispatches were attempted but did not return a valid
handoff; no provider reasoning is imported here.
