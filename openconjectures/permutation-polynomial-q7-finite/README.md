# Odd-q permutation-polynomial conjecture: q=7 finite replay

This packet checks the finite `q=7` slice of the conjecture in
[arXiv:2606.14529v1](https://arxiv.org/abs/2606.14529v1), observed 2026-07-20.
For `b,c,d` in `F_(q^2)` with `b^q != c`, the source asks whether
`x^(q+1) + b*x^q + c*x + d` can be a permutation polynomial. The packet
enumerates every admissible triple for `q=7` and checks all 49 inputs.

Result: `115248` admissible triples were checked and `0` were permutation
polynomials. This is a finite `q=7` result only; the general odd-`q`
statement remains unresolved here.

The field is represented as `F_7[i]` with `i^2=3`. The exact source packet
was observed at `https://arxiv.org/abs/2606.14529v1`; its pinned wrapper
digest is `95277064a05e891f38546ceafc9368c7b06cf809c4bb1e0452c685bc49d8ae78`.

## Replay

```sh
python3 checkers/verify.py
ruby checkers/verify.rb
```

Both separate replays must print `115248 0`.
