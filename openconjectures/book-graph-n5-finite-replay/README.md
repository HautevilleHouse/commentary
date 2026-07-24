# Book-graph domination polynomial: finite `n=5` replay

This packet checks the `n=5` slice of Conjecture 5.4 from
[arXiv:2604.08998v2](https://arxiv.org/abs/2604.08998v2), observed on
2026-07-22. The bounded task is to compute the exact rational Sturm root counts
for the quotient `D(B_5, x) / x^2`, where

`D(B_n, x) = (2x + 1)(x(x + 2))^n + x^2((x + 1)^2)^n - 2x^n`.

Result: the exact quotient polynomial is

`x^10 + 12*x^9 + 66*x^8 + 210*x^7 + 410*x^6 + 492*x^5 + 354*x^4 + 150*x^3 + 45*x^2 + 10*x + 1`

and it is square-free with `gcd(Q, Q') = 1`. Exact Sturm counts show:

- `0` roots in `(-infinity, -2)`
- `0` roots in `(-2, -1/2)`
- `2` roots in `(-1/2, 0)`
- `2` real roots in total

This is a finite `n=5` result only. The parity-dependent all-`n` conjecture
from the source remains open.

## Replay

```sh
python3 checkers/verify.py
ruby checkers/verify.rb
```

Both replays must print the same quotient, `gcd=1`, interval counts `0 0 2`,
and total real roots `2`.

The exact source scope is recorded in
[source/source_exact_statement.txt](source/source_exact_statement.txt), and the
pinned source identity is recorded in
[data/source_identity.json](data/source_identity.json).

## Local Formal State

This local packet also carries a bounded formal scaffold in `lean/`.

- `lean BookGraphN5Certificate.lean` passes locally and checks the exact
  bounded payload: the source expansion identity
  `D(B_5,x) = x^2 * Q(x)`, the recorded quotient polynomial, `gcd(Q,Q') = 1`,
  and the interval counts `0,0,2,2`.
- `lake env lean MathlibProof.lean` now also passes locally. The first broad
  cache attempts on 2026-07-22 were too large for the host volume, but the
  bounded `lake exe cache get Mathlib.Tactic.Ring` fetch succeeded and provided
  the Mathlib artifacts needed for the exact expansion proof.

This means the finite packet is replayable by the public Python/Ruby
checkers and by both Lean layers. A fresh clone from `origin/main` was also
replayed locally before publication. The packet is scoped strictly to the
finite `n=5` slice; the all-`n` conjecture remains open.
