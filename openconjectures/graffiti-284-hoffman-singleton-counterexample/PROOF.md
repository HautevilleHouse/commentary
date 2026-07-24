# Proof packet: Graffiti 284 fails on Hoffman–Singleton

## 1. Source-exact statement (usual WoW reading)

Let `G` be a connected simple graph of girth at least 5.  For a vertex `v` of
positive degree, the dual degree is

\[
d^*(v)=\frac1{\deg(v)}\sum_{u\sim v}\deg(u).
\]

Write `min_dual(G)` for the minimum of `d^*` and `D(G)` for the distance
matrix of `G`.  Graffiti conjecture 284 asserts

\[
\min\_dual(G)\le -\lambda_{\min}(D(G)).
\]

## 2. Hoffman–Singleton input facts

Let `H` be the Hoffman–Singleton graph.  The standard strongly regular
parameters are

\[
\operatorname{srg}(50,7,0,1).
\]

In particular `H` is connected, 7-regular, has diameter 2 and girth 5, and its
adjacency spectrum is

\[
\operatorname{Spec}(A)=\{7^{1},2^{28},(-3)^{21}\}.
\]

These are classical facts (Hoffman–Singleton; DistanceRegular.org; Rowlinson–
Sciriha).  Regularity immediately gives `d^*(v)=7` for every vertex, so

\[
\min\_dual(H)=7.
\]

## 3. Diameter-2 spectral bridge

For any connected diameter-2 graph,

\[
D=2(J-I)-A.
\]

On the all-ones eigenvector of a `k`-regular graph on `n` vertices this yields
eigenvalue

\[
2(n-1)-k.
\]

On the orthogonal complement of the all-ones vector, an adjacency eigenvalue
`θ` becomes

\[
-2-\theta.
\]

Specializing to Hoffman–Singleton (`n=50`, `k=7`) gives

\[
2(50-1)-7=91
\]

and

\[
-2-2=-4,\qquad -2-(-3)=1.
\]

Hence

\[
\operatorname{Spec}(D(H))=\{91^{1},1^{21},(-4)^{28}\},
\qquad
\lambda_{\min}(D(H))=-4.
\]

## 4. Contradiction

Graffiti 284 would require

\[
7\le -(-4)=4.
\]

But `7 ≰ 4`.  Equivalently the signed search score

\[
\min\_dual+\lambda_{\min}(D)=7-4=3
\]

is strictly positive, so Hoffman–Singleton is a counterexample under the usual
reading.

## 5. Control case

The Petersen graph is 3-regular of diameter 2 with adjacency spectrum
`{3^{1},1^{5},(-2)^{4}}`.  The same bridge yields distance spectrum
`{15^{1},0^{4},(-3)^{5}}`, so

\[
\min\_dual+\lambda_{\min}(D)=3-3=0.
\]

Petersen is therefore tight for the inequality and is not a counterexample.
This control is replayed by the dual-checker.

## 6. Verification boundary

The Python checker verifies the integer spectral identities and the Petersen
control.  The Lean/mathlib certificate checks the same bridge and the
proposition `¬ (7 ≤ 4)`.

Neither route constructs Hoffman–Singleton from first principles inside the
kernel.  Existence, girth, diameter, regularity, and the adjacency spectrum are
imported as externally certified classical facts.  Public statement proxies are
sealed in `data/source_seals/manifest.json`.  The Fajtlowicz Written-on-the-Wall
master list remains an external remainder (request-only; no public primary page
for the exact wording of conjecture 284).
