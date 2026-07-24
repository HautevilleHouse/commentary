# Feasible-Rank Monotonicity Under Subgroup Restriction

Let `H <= G` act on `M`. For fixed `epsilon`, let `F_K(epsilon)` be the set of
positive ranks `m` for which there exist:

1. a rank-`m` `K`-bundle over `M`;
2. a representation `rho_K: K -> O(m)`;
3. a `K`-equivariant section whose zero set has the required error less than
   `epsilon`.

The source definition says `m*(K, epsilon) = min F_K(epsilon)` whenever the
set is nonempty.

If `m` belongs to `F_G(epsilon)`, restrict its bundle action and `rho_G` to
`H`. The original section remains equivariant because its identity is true for
every element of `G`, hence for every element of `H`. The zero set and its
error are properties of the same section and do not change. Thus

```text
F_G(epsilon) is a subset of F_H(epsilon).
```

Taking minima gives `m*(H, epsilon) <= m*(G, epsilon)`. Applying this with
`H = G_data` proves the source's symmetry-efficiency statement.

The conclusion is definitional monotonicity. It does not require a comparison
of irreducible representations or an approximation construction.
