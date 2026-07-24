# q-Catalan bivariate interpretation: n=6 finite replay

This packet checks the `n=6` slice of the bivariate interpretation in
[arXiv:2605.14682v1](https://arxiv.org/abs/2605.14682v1), observed 2026-07-19.
For every `k=0,...,6`, it compares the source recurrence-defined
`C_(n,k)(q,p)` with the weighted sum over 312-avoiding permutations.

The exact checker enumerates all 132 valid permutations. Every one of the
seven bivariate coefficient tables agrees: `mismatch_count=0`.

This is only the finite `n=6` verification; the source's all-`n` conjecture
remains open. The pinned source archive digest is
`d597702ca95fa856c71b72f3c0ec96c2c3bd0cd163e6f15a35c15f23003ad28d`.

## Replay

```sh
python3 checkers/verify.py
```

The checker exits successfully and prints the exact coefficient tables.

## Literature boundary

The 312-avoiding/inversion interpretation is established combinatorics; prior
work includes the area-to-inversion bijection for 312-avoiding permutations.
This packet contributes a reproducible finite `n=6` replay record and does
not present the underlying interpretation as a new general theorem.
