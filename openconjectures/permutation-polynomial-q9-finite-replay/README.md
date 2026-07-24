# Odd-q permutation-polynomial conjecture — q=9 finite replay

For the source family

`f(x) = x^(q+1) + b*x^q + c*x + d`,

this packet checks the finite `q=9` restriction over
`F_81 = F_3[t]/(t^4+t+2)`, enumerating every `(b,c,d)` with `b^9 != c`.

The exhaustive result is **524,880 admissible triples and zero permutation
witnesses**. C++ and Python implementations agree.

This is a finite q=9 result only. It does not settle the source's general
odd-q conjecture. The provider supplied an exhaustive-search plan, not the
result; the reported count is established by the two separate replays.

## Replay

```sh
c++ -O3 -std=c++17 checkers/verify.cpp -o /tmp/permutation_poly_q9
/tmp/permutation_poly_q9
python3 checkers/verify.py
```
