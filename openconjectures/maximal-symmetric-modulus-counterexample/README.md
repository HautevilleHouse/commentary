# Maximal Symmetric Modulus Counterexample

Source object: OpenConjecture `3706`, arXiv:`2606.15624v2`,
`Averages-3.tex` lines `675-693`.

This packet gives a source-worded counterexample to the printed conjecture that
one may take `c_vee(d)=1` for every dimension in the maximal symmetric modulus
inequality.

## Public Claim Boundary

For

```text
A = [[ 2, 2],
     [-1, 2]]

B = [[2, 0],
     [0, 0]]
```

we have

```text
tr(|A|_vee)     = 6
tr(|B|_vee)     = 2
tr(|A+B|_vee)   = 4*sqrt(5)
```

The proposed `c_vee(2)=1` inequality would imply

```text
tr(|A+B|_vee) <= tr(|A|_vee) + tr(|B|_vee).
```

The exact trace gap is

```text
4*sqrt(5) - 8 > 0.
```

Thus the `c_vee(d)=1` conjecture fails already for real `2 x 2` matrices.

The trace values are certified by the singular spectra of `A`, `B`, and
`A+B`, together with the two-dimensional spectral-maximum rule for distinct
top eigendirections.

## Replay

Run from the repository root:

```bash
python3 openconjectures/maximal-symmetric-modulus-counterexample/checkers/replay_trace_counterexample.py
```

The checker writes `data/trace_counterexample_check_20260709.json`. It verifies
the integer Gram matrices, eigenvalue equations, top-eigendirection separation,
and the exact radical trace inequality.

## Files

- `data/source_identity.json` records the public source identity and source
  hashes.
- `checkers/replay_trace_counterexample.py` emits the deterministic certificate.
- `data/replay_receipt.json` records the replay command, hashes, and carried
  boundary.

## Carried Boundary

- The optimal value of `c_vee(d)` remains outside this packet.
- Dimension families beyond the displayed `2 x 2` counterexample remain outside
  this packet.
- This packet is a public checker packet rather than a Lean formalization.
