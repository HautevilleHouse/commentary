# CRIM non-hook Conway-pair counterexample family

This packet gives a source-exact counterexample to the non-hook exclusion in
Conjecture 6 of [arXiv:2606.16828v1](https://arxiv.org/abs/2606.16828).

The source defines a CRIM move by deleting one arbitrary row of a partition
and sorting the remaining rows. Normal Grundy recursion assigns the empty
partition value `0`; misère recursion assigns it value `1`. The source's
even-by-even hooks have Conway pair `(0,1)` and asks whether non-hooks can also
have that pair.

For every integer `m >= 2`, the non-hook partition `[m,2]` has Conway pair
`(0,1)`. Its two row-deletion options are `[m]` and `[2]`. Each one-row
partition has normal value `1` and misère value `0`, so `[m,2]` has normal
`mex {1} = 0` and misère `mex {0} = 1`.

This refutes the hook-only exclusion. It does not address other CRIM
conjectures or the source's broader classification questions.

## Replay

```bash
python3 checkers/verify.py
ruby checkers/verify.rb
```

Both checkers compute the recursion for `m=2..32` and verify
the parametric two-row argument.

## Source and status

- Source: arXiv:2606.16828v1, Conjecture 6 (`conj:hookswap`), observed 2026-07-20.
- Exact source statement used for replay: `synthetic://crim-cp01-exact-statement-20260719`.
- Status: internally verified counterexample family.
