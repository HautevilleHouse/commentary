# LEGO Polynomial Reciprocity

Source paper: Anthony J. Guttmann and Rasmus M. Nilsson,
[Counting LEGO configurations](https://arxiv.org/abs/2605.07380v1),
arXiv:`2605.07380v1`.

Source object: Conjecture 1.

## Source Statement

For fixed `n`, let `p_n(w)` count the paper's connected, flat, oriented
structures made from `n` parallel `w x 1` tiles, up to translation. The
paper proves that `p_n` is a polynomial of degree `n-1` and conjectures

```text
p_n(1-w) = (-1)^(n-1) p_n(w).
```

## Theorem

The conjectured identity holds for every positive integer `n`.

The proof decomposes each labelled vertical pattern into a finite signed sum
of lattice-point enumerators of connected-graph Lipschitz polytopes. Every
polytope in that sum is integral, has dimension `n-1`, and satisfies the same
shifted Ehrhart reciprocity identity. The common sign therefore survives
Möbius inversion, same-row inclusion-exclusion, and removal of tile labels.

See [PROOF.md](PROOF.md) for the complete argument.

## Replay

Requirements:

- Python 3;
- no third-party packages.

Run from the repository root:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 openconjectures/lego-polynomial-reciprocity/checkers/verify.py
```

The verifier separately:

1. checks all eight coefficient rows printed in the source;
2. checks the shifted reciprocity identity for every connected simple graph
   on at most four vertices; and
3. reconstructs the source's geometric counts directly for every
   `1 <= n <= 4` and `1 <= w <= n`.

The finite replay checks transcription and model fidelity. The proof in
[PROOF.md](PROOF.md) establishes the arbitrary-`n` theorem.

## Files

- `PROOF.md` gives the source-exact proof and references.
- `checkers/verify.py` performs the separate finite replay.
- `data/source_identity.json` binds the packet to the versioned source bytes.
- `data/prior_public_resolution_search_20260718.json` records the bounded,
  dated prior-resolution search.
- `data/verification_result_20260718.json` stores the deterministic replay
  output.
- `data/replay_receipt.json` records the replay result and packet hashes.

## Claim Boundary

- The theorem resolves Conjecture 1 for the oriented, flat structures and
  translation convention defined in the source paper.
- The result concerns the polynomial identity. The paper's asymptotic
  conjectures and three-dimensional counting questions remain outside this
  packet.
- The finite checker supports source fidelity; finite extrapolation is not
  used in the proof.
- The prior-resolution search is dated and bounded. Unpublished, unindexed,
  or differently worded work remains outside its scope.
