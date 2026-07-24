# Directed-cycle avalanche counterexample

This packet gives a source-exact counterexample to OpenConjecture 4244 in
Riihimäki and Smith, *Avalanche homology of digraphs via sandpile dynamics*
(arXiv:2606.26786v1).

Take the directed cycle `C_3`, let `k = 2`, and start from the binary
configuration

```text
c_0 = (1,0,1).
```

Its zero positions are exactly

```text
[2]_2 = {j : j = 2 (mod 2), 1 <= j <= 3} = {2},
```

and `|c_0| = 2 > 1`, so every printed hypothesis holds.  Parallel firing
cycles through the three firing sets

```text
{v1,v3}, {v1,v2}, {v2,v3}.
```

Their downward closure is the boundary of a triangle, hence is homotopy
equivalent to `S^1`.  The conjecture predicts `S^(k-2) = S^0`, so the printed
statement is false.

The same example also contradicts the preceding source lemma labelled
`lem:modcycle`: its non-zero positions are `[1]_2 = {1,3}`, but its avalanche
complex is connected rather than two disconnected points.

## Replay

Run from the packet root:

```bash
python3 checkers/verify.py
```

The Python verifier implements the paper's parallel-firing rule directly from
the directed edges, constructs the downward-closed complex, and computes
simplicial homology over `F_2`.  It then compiles and runs a separate C++20
checker that represents the dynamics as cyclic bit rotation and verifies the
triangle-boundary topology by a separate graph calculation.  Finally it
checks the packet receipt.

## Scope

This packet disproves the statements exactly as printed in
arXiv:2606.26786v1.  Classification of all cycle configurations and any
repaired statement with an added divisibility or cyclic-coset hypothesis remain
outside its scope.  The dated public-resolution search records bounded
