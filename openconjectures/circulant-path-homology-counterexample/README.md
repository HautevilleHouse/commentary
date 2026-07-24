# Circulant Path-Homology Counterexample

## Summary

This packet checks one explicit 13-vertex circulant digraph and finds the
claimed universal path-homology conclusion fails for that example. Run
`./replay.sh` to reproduce the finite calculation.

Source paper: Xinxing Tang and Shing-Tung Yau,
[Path Homology of Circulant Digraphs](https://arxiv.org/abs/2602.04140v1).

Source object: OpenConjecture `686`, arXiv:`2602.04140v1`, conjecture in
`circulantarXiv.tex`, lines `1230-1235`. The source defines the directed
circulant `C_n^S` by the arrows `a -> a+s` for `a in Z_n` and `s in S` at
lines `561-565`, and defines its GLMY path complex at lines `246-280`.

## Source Claim

For every connection set

```text
S = {1, gamma_1, ..., gamma_(d-1)},
1 < gamma_1 < ... < gamma_(d-1) < n/2,
```

the source conjectures

```text
H_m^path(C_n^S) = 0 for every m >= 3.
```

## Counterexample

Take `n=13` and `S={1,4,6}`. This satisfies the source hypotheses because
`1 < 4 < 6 < 13/2`.

For each `a in Z_13`, let `[a;s,t,u]` denote the allowed 3-path with vertices

```text
a, a+s, a+s+t, a+s+t+u
```

read modulo `13`. Define the translation-invariant 3-chain

```text
Z = sum_(a in Z_13) (
      -[a;1,4,6] + [a;1,6,4] + [a;4,1,6]
      -[a;4,6,1] - [a;6,1,4] + [a;6,4,1]
    ).
```

Each interior deletion merges two of `1,4,6` into one of `5,7,10`, none of
which belongs to `S`. For every resulting forbidden face, the two relevant
permutations occur with opposite coefficients. Thus `Z` lies in `Omega_3`.
The endpoint faces cancel in the displayed alternating sum, so `partial Z=0`.
The chain has 78 distinct nonzero elementary-path terms.

It remains to show that `Z` is not a boundary. It suffices to consider the
translation-invariant subcomplex. If `partial B=Z`, averaging `B` over the
13 translations gives a translation-invariant 4-chain whose boundary is
`13 Z`.

For an invariant 4-chain, write one coefficient for each step word in
`S^4`, giving 81 unknowns. The condition that every forbidden interior face
cancel is a 162-by-81 integer matrix. The checker constructs this matrix from
the GLMY boundary definition and gives an exact 81-by-81 minor with
determinant `1`. Hence the invariant `Omega_4` is zero. Therefore `Z` cannot
be a boundary, and

```text
H_3^path(C_13^{1,4,6}) != 0.
```

This contradicts the universal source claim.

## Verification

Run from the repository root:

```bash
python3 openconjectures/circulant-path-homology-counterexample/checkers/verify_counterexample.py
```

The standard-library checker constructs the forbidden-face matrices, verifies
the alternating cycle and its zero boundary, produces an exact determinant-one
minor for invariant 4-chains, and writes
`data/counterexample_check_20260717.json`.

## Files

- `data/source_identity.json` records the exact source object and hashes.
- `checkers/verify_counterexample.py` constructs and verifies the certificate.
- `data/counterexample_check_20260717.json` is the checker output.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/verification_receipt.json` records the checker hash and claim boundary.

## Claim Boundary

- The packet refutes the exact universal statement by the admissible directed
  circulant `C_13^{1,4,6}`.
- The packet proves only that `H_3^path(C_13^{1,4,6})` is nonzero; it does not
  compute the full path-homology sequence or its exact third Betti number.
- The packet does not address the source's undirected circulant graphs.
  assert that no one has found this counterexample elsewhere.
