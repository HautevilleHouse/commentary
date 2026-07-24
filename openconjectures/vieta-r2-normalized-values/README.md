# Vieta r=2 Normalized Values

Source paper: Steven J. Miller, Dimitrios Nikolakopoulos, and Anitha
Srinivasan,
[Fibonacci Numbers and Vieta Jumping for a Rational Diophantine Equation](https://arxiv.org/abs/2605.19083v2).

Source object: OpenConjecture `2765`, arXiv:`2605.19083v2`, Conjecture `4.2`
in `FibNumbVietaJumpRatDiophEq_MNS_v10.tex`, lines `942-958`.

## Theorem

Let `a` and `b` be positive integers satisfying

```text
(a+2)/b + (b+2)/a = k
```

for an integer `k`. Then

```text
2(a+b)/gcd(a,b)^2 in {1,2,3,4,5,8}.
```

The values for `k=3` are `{1,5}`, the values for `k=4` are `{2,3}`, and the
values for `k=6` are `{4,8}`.

## Proof

The source's Remark 4.1 proves that `k` belongs to `{3,4,6}` and that every
solution reaches the corresponding diagonal solution through Vieta jumps

```text
(a,b) -> (kb-2-a,b),
(a,b) -> (a,ka-2-b),
```

and coordinate flips. The diagonal solutions are `(4,4)` for `k=3`, `(2,2)`
for `k=4`, and `(1,1)` for `k=6`.

For `k=3,4`, both diagonal coordinates are even, and each jump or flip
preserves this parity. Write `a=2A` and `b=2B`. The equation becomes

```text
(A+1)/B + (B+1)/A = k,
```

while

```text
2(a+b)/gcd(a,b)^2 = (A+B)/gcd(A,B)^2.
```

Theorem 3.5 of the source proves that the expression on the right has values
`{1,5}` for `k=3` and `{2,3}` for `k=4`.

For `k=6`, the diagonal coordinates are odd, and the jumps and flips preserve
oddness. Set

```text
d = gcd(a,b),  x = a/d,  y = b/d,
Q = 2(a+b)/d^2.
```

Then `x` and `y` are coprime odd positive integers. Multiplying the original
equation by `ab` and dividing by `d^2` gives

```text
Q = 6xy-x^2-y^2,
dQ = 2(x+y).
```

The first identity gives `gcd(Q,xy)=1`, and the second gives `Q | 2(x+y)`.
Also,

```text
(x+y)^2 = 8xy-Q.
```

Squaring the divisibility relation therefore yields `Q | 32xy`. Coprimality
reduces this to `Q | 32`. Since `x` and `y` are odd, `8xy` is congruent to `8`
modulo `16`, while `(x+y)^2` is congruent to `0` or `4`. Thus `Q` is
congruent to `8` or `4` modulo `16`. Among the positive divisors of `32`, this
leaves exactly `Q in {4,8}`.

Every listed value occurs:

```text
k=3: (4,4) -> 1,  (4,6) -> 5
k=4: (2,2) -> 2,  (2,4) -> 3
k=6: (1,1) -> 4,  (1,3) -> 8
```

This proves Conjecture 4.2.

## Replay

Run from the repository root:

```bash
python3 openconjectures/vieta-r2-normalized-values/checkers/replay_resolution.py
```

The standard-library checker verifies the six attainment witnesses, the odd
residue argument modulo `16`, the divisor reduction, and all positive
solutions with `a,b <= 1000`. It writes
`data/resolution_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/replay_resolution.py` verifies the arithmetic evidence.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/replay_receipt.json` records replay hashes and the claim boundary.

## Claim Boundary

- The packet proves Conjecture 4.2 using Remark 4.1 and Theorem 3.5 of the
  cited source together with the displayed `k=6` argument.
- The bounded computation supplies reproducible supporting evidence; the
  symbolic proof supplies the all-positive-integer result.
- General `r`, the source's three-variable equation, and its other open
  problems remain outside this packet.
