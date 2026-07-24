# Erdős 624: finite `H(4)=3` replay

This packet settles only the finite `X={0,1,2,3}` slice of the powerset
covering function in Erdős Problem 624. It does not settle the asymptotic
conjecture.

The exact source-defined construction has `f(∅)=0`; the six two-element
subsets are colored by the three perfect matchings of `K₄`. Every 3-element
set contains one pair from each matching, so `m=3` works. A counting
obstruction excludes `m≤2`.

## Replays

```sh
python3 checkers/verify_h4.py
ruby checkers/verify_h4.rb
```

Both implementations must print:

```text
H(4)=3; m0/m1/m2 lower bound; m3 construction passes 5 triples
```

The source-exact statement, hashes, result receipt, and claim boundary are
in `source/source_exact_statement.txt` and `result.json`. The required public
DeepSeek dispatches were attempted but truncated; this packet relies on the
explicit finite construction and separate replays, not on an imported
provider answer.
