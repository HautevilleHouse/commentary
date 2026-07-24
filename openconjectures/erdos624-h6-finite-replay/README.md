# Erdős 624: finite `H(6)=3` replay

This packet settles only the finite six-color slice of the powerset-covering
function in Erdős Problem 624. It does not settle the asymptotic conjecture.

The 64-entry truth table is ordered by subset cardinality and then
lexicographic combination order. Every target set of size 3 through 6 sees
all six colors. A target of size 2 has only four subsets, so `m<=2` is
impossible for six colors.

## Replays

```sh
python3 checkers/verify_h6.py
ruby checkers/verify_h6.rb
```

Both implementations must report `H(6)=3` and successful
coverage for every target of size at least 3. The source-exact statement,
hashes, result receipt, and claim boundary are in `source/` and `result.json`.
The required public delegate attempts did not return a valid handoff; no
provider reasoning is imported here.
