# Nine arithmetic-function inequalities

This packet proves Conjectures 1--9 of
[arXiv:2606.12484v1](https://arxiv.org/abs/2606.12484v1), indexed as
OpenConjecture 3856--3864.

## Result

For every integer `n >= 2` and `k >= 1`, all nine inequalities hold.
Equality in any one of them occurs precisely when `n` is prime.

The proof reduces the nine statements to two inequalities for an ordered
positive triple and one elementary lemma relating Euler's totient, Dedekind's
psi function, and the divisor-sum function.  The complete argument is in
[PROOF.md](PROOF.md).

## Replay

Run the separate exact checker:

```bash
python3 checkers/verify.py
```

Build the algebraic certificates with Lean/mathlib:

```bash
cd lean
lake build
```

The Python checker uses two separate implementations of the arithmetic
functions, exact rational arithmetic, and symbolic identity checks.  Its
finite range is corroboration only; the universal result comes from the proof.

## Evidence boundary

- `data/source_identity.json` fixes the source version, source lines, and
  OpenConjecture identifiers.
- `data/prior_public_resolution_search_20260718.json` records a dated search
  for an earlier public resolution.
- The Lean file checks the ordered-triple identities and the algebraic
  induction-step certificates used by the proof.
- This packet has separate machine replay but no external expert review yet.

The source paper and its cited literature remain the work of their respective
authors.  This packet addresses only the exact conjectures identified above.
