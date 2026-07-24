# Stack-Sort Motzkin Bijection

Source object: OpenConjecture `1878`, arXiv:`2604.10779v2`,
`stacksortingdiagrams.tex` lines `127-130`, `516-528`, `742-763`,
`817-821`, and `870-873`.

This packet now includes a Lean 4 formalization layer for the bounded
Motzkin-bijection route.

## Public Claim Boundary

The source theorem `PT` counts permutations for a fixed composition diagram and
linear extension by a product of hook factors. For row lengths in `{1,2}`, every
hook factor is `1`. Thus `|W'_2(n)|` is the number of pairs `(alpha,T)` with
`alpha` a composition of `n` with parts `1` or `2` and `T` a linear extension of
`D(alpha)`.

For such an `alpha`, write:

```text
A_j = (1,j)
B_j = (2,j) when row j has length 2
```

The extension constraints are exactly that the `A` cells form a chain, the `B`
cells form a chain, and every `B_j` appears after its matching `A_j`.

Read a linear extension from greatest to least:

```text
A_j from a length-1 row -> horizontal step
A_j from a length-2 row -> up step
B_j                    -> down step
```

The condition that each `B_j` follows `A_j` is the Motzkin prefix condition.
The inverse construction reads a Motzkin path, creates a length-1 row for each
horizontal step, creates a length-2 row for each up step, and matches down steps
to the open length-2 rows in order.

The Lean target closes the encoded inverse-to-forward roundtrip:

```text
inversePath initialInverseState steps = some st
  -> forwardPath st.rowLengthsRev.reverse st.extensionRev.reverse = some steps
```

So the public packet now contains both the source-level bijection summary and a
machine-checked Lean replay layer for the encoded construction.

## Replay

From this folder:

```bash
cd lean
cd openconjectures/stack-sort-motzkin-bijection/lean && lake build StackSortMotzkinBijection
```

The included build receipt records the checked local target build used for
publication. The public folder is replayable through the included
`lean-toolchain`, `lakefile.toml`, and `lake-manifest.json`; build caches such
as `.lake/` are not part of the repository.

## Files

- [Lean target](lean/StackSortMotzkinBijection.lean)
- [Source identity](data/source_identity.json)
- [Replay receipt](data/replay_receipt.json)
- [Checker output](data/motzkin_bijection_check_20260709.json)
- [Lean build receipt](data/build_receipt.json)
- [Lean build log](data/lean_build_20260712.log)

## Carried Boundary

- This packet relies on the source theorem package cited above.
- The Lean file checks the encoded Motzkin-bijection route, not the full paper.
- Broader stack-sorting questions outside `W'_2(n)` remain outside this packet.
