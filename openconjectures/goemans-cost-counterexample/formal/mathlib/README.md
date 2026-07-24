# Mathlib-backed replay

`GoemansMathlib.lean` is the Mathlib-backed version of the finite Goemans
witness replay. It proves the same instance-specific facts as the standalone
Lean file using `Mathlib.Data.Fin.Basic`.

Verified locally with:

- Mathlib commit `17b4b96c4eb874624e9cab005e966a25fd68ab14`
- Mathlib `lean-toolchain`: `leanprover/lean4:v4.33.0-rc1`

From a checkout of that Mathlib revision, place this file in the project root
and run:

```sh
lake exe cache get
lake env lean GoemansMathlib.lean
```

This remains a finite, seven-vertex replay; it does not resolve the general
Dinitz–Garg–Goemans conjecture.
