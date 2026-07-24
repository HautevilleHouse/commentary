# q,p-Catalan bivariate interpretation — proof and boundary repair

This packet records an internally verified proof of Conjecture 5.4 in
arXiv:2605.14682v1 on the source's unambiguous range `0 <= k < n`, together
with a proof of its natural saturated completion at `k=n`. The weighted sum
over 312-avoiding permutations whose maximum occurs in the first `k+1`
positions equals the bivariate recurrence polynomial throughout that range.

## Proof certificate

The exact source excerpt is retained in `data/source_exact_statement.txt`.

Let `A_(n,k)` be the weighted sum, with weight
`q^Inv(pi) p^Coinv(pi)`. For `1 <= k < n`, partition by whether the maximum
`n` occurs before position `k+1`. In the second class insert `n` at position
`k+1` into `S'_(n-1,k)`. The inverse deletes `n`. For 312-avoiding
permutations this is a bijection: the suffix after the maximum is decreasing,
so insertion creates no forbidden pattern, and deletion preserves avoidance.
The insertion adds `n-k-1` inversions and `k` co-inversions. Hence

`A_(n,k) = A_(n,k-1) + q^(n-k-1) p^k A_(n-1,k)`.

The base row is the unique decreasing permutation,
`A_(n,0)=q^binom(n,2)`. At `k=n`, all maximum positions are included, so
`A_(n,n)=A_(n,n-1)`. The source explicitly gives an out-of-range-zero
convention only for its earlier one-variable triangle. The later bivariate
definition does not repeat it, even though its displayed `k=n` recurrence
uses `C_(n-1,n)(q,p)`. Accordingly, induction proves the literal source
statement for `0 <= k < n`; adopting the natural boundary
`C_(n,n)(q,p):=C_(n,n-1)(q,p)` proves the full intended range.

The complete proof is included above; the private research copy is retained
for provenance.

## Separate replay

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

The packet checkers pass separately (Python through `n=9`, Ruby through
`n=8`).

## Scope

This is a proof of the source's bivariate Conjecture 5.4 on `0 <= k < n` and
of its natural saturated completion at `k=n`. Literal source-exact treatment
of `k=n` requires the disclosed boundary convention. The packet does not
settle the other q-Catalan, multivariate, or cyclotomic conjectures.
