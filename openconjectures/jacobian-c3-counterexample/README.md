# Reported dimension-3 Jacobian-Conjecture counterexample

Status: **Lean-formalized replay.**

This packet replays a publicly reported dimension-3 polynomial map. The displayed
construction is sealed in this packet’s checkers and Lean certificates.
Structural context is [arXiv:2606.22041v1](https://arxiv.org/abs/2606.22041v1).

## Exact map and claim boundary

For variables `x,y,z`, define

```text
F1 = (1+x*y)^3*z + y^2*(1+x*y)*(4+3*x*y)
F2 = y + 3*x*(1+x*y)^2*z + 3*x*y^2*(4+3*x*y)
F3 = 2*x - 3*x^2*y - x^3*z
```

The checker computes `det(DF) = -2` and verifies that the three distinct
points `(0,0,-1/4)`, `(1,-3/2,13/2)`, and `(-1,3/2,13/2)` all map to
`(-1/4,0,0)`. Thus the displayed map is non-injective in dimension 3.
Multiplying one output coordinate by `-1/2` gives determinant `1` while
preserving non-injectivity.

This packet addresses only the displayed dimension-3 map.

## Replay

```bash
python3 checkers/verify.py
```

Expected output is JSON with `determinant: "-2"`, three identical images, and
`all_distinct_inputs: true`.

The `lean/Counterexample.lean` file kernel-checks the three
rational evaluations, pairwise distinctness, and the determinant expression at
each collision point using `native_decide`. The SymPy replay additionally
checks that the full symbolic determinant is the constant `-2`.
It also formalizes the coordinate rescaling, the scaled collision, and an
explicit non-injectivity witness.

## Sources

- Structural context: [arXiv:2606.22041v1](https://arxiv.org/abs/2606.22041v1)
- Packet certificates: this repository path
  [`openconjectures/jacobian-c3-counterexample`](https://github.com/HautevilleHouse/commentary/tree/main/openconjectures/jacobian-c3-counterexample)

The checker is a separate symbolic and Lean replay of the displayed map
recorded in this packet.

The Mathlib-backed proof source is `lean/MathlibProof.lean`; it proves the
global polynomial identity with Mathlib's `ring` tactic. Its pinned project
metadata is in `lean/lakefile.toml`, `lean/lake-manifest.json`, and
`lean/lean-toolchain`. Replay with `lake env lean MathlibProof.lean` from the
`lean/` directory under the pinned Lean `v4.28.0` / Mathlib revision used by
this commentary shelf.
