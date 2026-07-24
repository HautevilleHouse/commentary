# Rank-2 Poisson conjecture counterexample replay

Status: **SymPy exact replay.**

This packet replays the explicit rank-2 Poisson endomorphism displayed in
Christopher D. Long’s public GitHub writeup of 2026-07-21 (repository
`octonion/mathematics`, directory `poisson/`).

## Exact map and claim boundary

Let

```text
P_2 = C[x, q, p, z]
```

carry the canonical Poisson bracket with `{p,x} = {z,q} = 1` and all other
brackets among distinct generators equal to zero. Define intermediate

```text
a = 1 - 3*x*q
B = 3*x^2*p + 2*a*z
beta = B - 9*q^2
y = q - x*beta/3
u = x*y
```

and

```text
R = 2*x - 3*x^2*y - x^3*beta
S = y + 3*x*(1 + x*y)^2*beta + 3*x*y^2*(4 + 3*x*y)
T = -1/2 * ((1 + x*y)^3*beta + y^2*(1 + x*y)*(4 + 3*x*y))
D0 = 1/2*(1 + 3*x*q)*p - 3*q^2*z
H = (1/20)*y^4*(18*u^2 + 78*u + 125)
    + (3/10)*beta*y^2*(u^3 + 5*u^2 + 10*u - 5)
    - (1/6)*beta^2*(9*u + 2)
    - (1/6)*x^2*beta^3
D = D0 + H
```

The checker verifies, over `QQ`:

```text
{D,R} = 1
{S,T} = 1
{R,S} = {R,T} = {D,S} = {D,T} = 0
R = x*(2 - 3*x*q)
det J(R,T,D,S) = 1
```

and that the three distinct points

```text
(0, 0, 1/24, -1/8)
(1, 2/3, 247/96, -89/64)
(-1, -2/3, 247/96, -89/64)
```

all map under `(R,T,D,S)` to

```text
(0, 1/8, 0, 0).
```

Thus the assignment `(x,q,p,z) ↦ (R,T,D,S)` is a Poisson endomorphism of
`P_2` that fails to be injective on points, so it is not an automorphism.
Under the Adjamagbo–van den Essen indexing, this is a witness that `PC(2)`
fails.

This packet addresses only the displayed four-variable Poisson endomorphism
and the listed identities. The two-variable Jacobian conjecture `JC(2)` is
outside the closed object. The author’s Dixmier/`A_4` appendix is not replayed
here. No Lean formalization of this witness is included in the packet.

## Replay

From the repository root:

```bash
python3 openconjectures/poisson-pc2-counterexample/checkers/verify_poisson_pc2.py
```

Expected stdout is JSON with `jacobian_determinant: "1"`, all listed Poisson
bracket values, `all_distinct_inputs: true`, and `endpoint_check: true`.

Dependency marker: `checkers/requirements.txt` (`sympy`).

## Sources

- Primary construction writeup:
  https://github.com/octonion/mathematics/tree/main/poisson  
  TeX title: *An Explicit Counterexample to the Rank-Two Poisson Conjecture*
  (dated 2026-07-21). Pinned source commit recorded in
  `data/source_identity.json`.
- Indexing / implication chain context:
  Adjamagbo–van den Essen, arXiv:math/0608009.
- Related ambient context after the dimension-3 Jacobian counterexample:
  see also this repository’s
  [`jacobian-c3-counterexample`](../jacobian-c3-counterexample/) packet.

## Artifacts

- [Source identity](data/source_identity.json)
- [Replay script](checkers/verify_poisson_pc2.py)
- [Dependency marker](checkers/requirements.txt)
- [Replay output](data/replay_output_20260723.json)
- [Replay receipt](data/replay_receipt.json)
- [Leakage and style scan](data/leakage_style_scan.json)
- [Packet inventory](data/public_packet_inventory.json)

## Carried boundary

- `JC(2)` remains open.
- Lean formalization of this Poisson witness is not part of this packet.
- The author’s Weyl-algebra / Dixmier appendix is not certified here.
