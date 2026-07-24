# Odd-q permutation-polynomial conjecture: q=5 finite replay

This packet exhaustively checks the q=5 slice of [arXiv:2606.14529v1](https://arxiv.org/abs/2606.14529), observed 2026-07-20. For every admissible `(b,c,d)` in `F_25^3` with `b^5 != c`, it tests whether `x^6 + b*x^5 + c*x + d` permutes `F_25`.

Result: all `15,000` admissible triples were checked and `0` were permutation polynomials. This is a finite q=5 result only; the general odd-q conjecture remains open. The filtered count corrects an earlier provider count of 15,625.

## Replay

```sh
python3 checkers/verify.py
ruby checkers/verify.rb
```

Both separate replays print `15000 0`.
