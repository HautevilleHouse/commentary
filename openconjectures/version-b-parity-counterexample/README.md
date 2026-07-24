# Version B parity-classification counterexample

This packet gives a source-exact counterexample to Conjecture 2.1 of
*Generalizing OOOOOOB* (arXiv:2605.23213v1; OpenConjecture 2620).

Let

```text
X = (5,5,5,5,5,5,5,6,6,6,6,6).
```

There are `k = 12` piles, `ceil(k/3) = 4`, every pile is larger than 4,
and exactly seven piles are odd.  The printed `k = 0 mod 4` case therefore
classifies `X` as a P-position.  But the legal all-piles move sends `X` to

```text
Y = (4,4,4,4,4,4,4,5,5,5,5,5),
```

and exact replay gives `SG(X) = 2` and `SG(Y) = 0`.  Hence `X` is an
N-position with a move to the P-position `Y`, contradicting the conjecture.

## Replay

Run:

```bash
python3 checkers/verify.py
```

The verifier performs a separate recursive Python outcome computation,
compiles the separate bottom-up C++ Sprague--Grundy enumerator, checks every
multiset with at most 12 piles and pile sizes at most 10, and validates the
packet receipt.

The packet also includes a Lean certificate pinned to Lean `v4.28.0` (stdlib
Lake package).  It checks the source-side numerical hypotheses, the printed
parity clause, the legal all-piles move, and the logical implication from a
move to a P-position to the target not being a P-position.  Replay it
separately with:

```bash
cd lean
lake build
```

The Lean certificate deliberately does not formalize the exhaustive
Sprague--Grundy computation.  The two separate programs establish
`SG(Y) = 0`; Lean checks the finite source facts and the bridge from that fact
to the contradiction.

## Scope

This disproves only Conjecture 2.1 as printed in arXiv:2605.23213v1.  It does
not classify all Version B positions, address Versions A or C, or propose a
repaired threshold.  The dated public-resolution search is bounded and is not
described above and is not represented as a formalization of the game solver.
