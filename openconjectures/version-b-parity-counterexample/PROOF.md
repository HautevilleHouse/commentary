# Proof and exact-computation boundary

## Source rule

A Version B move either removes one token from one pile or removes one token
from every pile.  Empty piles disappear.  Under normal play, the empty
position has Sprague--Grundy value zero and

\[
g(P)=\operatorname{mex}\{g(Q):Q\text{ is a legal option of }P\}.
\]

The source's own Maple procedure `ValB` implements the same recurrence.

## Counterexample

Set

\[
X=(5^7,6^5).
\]

For `k=12`, the source threshold is
\(m=\lceil 12/3\rceil=4\), so every pile of `X` is strictly larger than
`m`.  Seven piles are odd.  In the `k = 0 mod 4` clause, seven lies in the
printed upper sequence

\[
k/2+1,\ldots,k-5,k-3,k-1=7,9,11,
\]

so Conjecture 2.1 predicts that `X` is a P-position.

Removing one token from every pile is legal and gives

\[
Y=(4^7,5^5).
\]

The separate exact computations in this packet give

\[
g(X)=2,\qquad g(Y)=0.
\]

Thus `X` has a legal move to a P-position and is itself an N-position.  This
contradicts the predicted classification and disproves Conjecture 2.1.

## Why the finite computation is exhaustive

Both programs canonicalize a position by its multiset of positive pile sizes.
Every legal option strictly decreases the total number of tokens, so the game
graph is finite and acyclic.

The Python implementation recursively evaluates the exact option relation and
memoizes only by canonical position.  The C++ implementation is separate:
it enumerates all 646,646 multiplicity vectors with at most 12 piles and pile
sizes at most 10, orders them by total tokens, and computes the mex bottom-up.
It tests all 26,286 positions satisfying the source threshold for 3 through 12
piles.  Its first mismatch is exactly `(5^7,6^5)` at 12 piles; no mismatch is
found in the paper's stated range through 11 piles.

## Lean certificate and its boundary

`lean/VersionBParityCounterexample.lean` is checked with Lean and Mathlib
`v4.28.0` at the revisions fixed by `lean/lake-manifest.json`.  Kernel
computation proves:

- `target.length = 12`;
- every target pile is strictly larger than 4;
- the target has exactly seven odd piles;
- the printed `k = 0 mod 4` clause evaluates to true for `(k, odd) = (12, 7)`;
- removing one token from every target pile gives exactly `Y`; and
- for any P-position predicate satisfying the ordinary move-to-P rule,
  `Y` being P implies that `X` is not P.

The certificate does **not** formalize the full Sprague--Grundy recurrence or
prove inside Lean that `g(Y)=0`.  That premise is supplied by the two
separate exhaustive programs.  This split is intentional: the formal file
checks the source boundary and logical bridge without overstating the scope of
the mechanization.
