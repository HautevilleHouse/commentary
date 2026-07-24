# Continued fraction target `k=1`, `N=3`

The pinned source defines `S_N = sum_{j=1}^N j^-3`, `R_N = zeta(3)-S_N`,
and `g(N)=sqrt(R_N/2)`. Its first open formal target predicts partial
quotients `7,14` at `N=3`. This packet verifies exactly that bounded slice.

Both checkers use rational interval bounds for `zeta(3)`: after the first
5,000 terms, the tail lies between the integral bound and that bound plus
the first omitted term. Squared rational inequalities imply `a1=7` and
`a2=14` without floating-point assumptions.

This is a finite `k=1` result only. It does not prove the all-`k` or all-`N`
continued-fraction conjecture.

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```
