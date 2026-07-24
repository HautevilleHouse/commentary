# Proof of LEGO Polynomial Reciprocity

## 1. Source and theorem

Guttmann and Nilsson define `p_n(w)` as the number of connected, flat,
oriented structures made from `n` parallel `w x 1` tiles, counted up to
translation. Tiles on the same row have disjoint horizontal cell intervals.
Tiles on adjacent rows interlock exactly when their horizontal cell intervals
overlap. Their Conjecture 1 states

\[
p_n(1-w)=(-1)^{n-1}p_n(w).
\]

We prove this identity for every positive integer `n`.

## 2. Labelled placements with a fixed vertical pattern

Put \(d=n-1\) and \(t=w-1\). Temporarily label the tiles by
\(V=\{0,1,\ldots,n-1\}\). Translate horizontally so that tile `0` has
left endpoint \(x_0=0\), and translate vertically so that the minimum
vertical coordinate is zero. Write the vertical coordinates as
\(y=(y_0,\ldots,y_{n-1})\).

In a connected structure, every tile is reached from a tile on the bottom
row through at most \(n-1\) interlocking steps. Hence every occupied row lies
in \(\{0,\ldots,n-1\}\), so only finitely many normalized vectors `y` occur.

For fixed `y`, define

\[
A_y=\{\{i,j\}:|y_i-y_j|=1\},\qquad
S_y=\{\{i,j\}:y_i=y_j\}.
\]

For a pair \(e=\{i,j\}\), let \(O_e(t)\) denote

\[
|x_i-x_j|\le t.
\]

For integer tile length \(w=t+1\), this is precisely the condition that the
two horizontal cell intervals overlap. A labelled placement with vertical
pattern `y` is therefore valid and connected exactly when

1. no event \(O_s(t)\), with \(s\in S_y\), occurs; and
2. the graph with edge set
   \(\{e\in A_y:O_e(t)\text{ occurs}\}\) is connected.

## 3. A signed sum of closed overlap conditions

For \(F\subseteq A_y\), define

\[
c_y(F)=\sum_{E\subseteq F}(-1)^{|F|-|E|}
\mathbf 1\{(V,E)\text{ is connected}\}.
\]

Boolean-lattice Möbius inversion gives, for every \(H\subseteq A_y\),

\[
\mathbf 1\{(V,H)\text{ is connected}\}
=\sum_{F\subseteq H}c_y(F).                                      \tag{1}
\]

If \(c_y(F)\ne0\), then `F` contains a connected spanning edge set and is
itself connected. Same-row exclusion has the inclusion-exclusion expansion

\[
\prod_{s\in S_y}(1-\mathbf 1_{O_s(t)})
=\sum_{R\subseteq S_y}(-1)^{|R|}
  \prod_{s\in R}\mathbf 1_{O_s(t)}.                            \tag{2}
\]

Let \(N_y(t)\) be the number of valid labelled placements with vertical
pattern `y`. Combining (1) and (2) yields

\[
N_y(t)=
\sum_{F\subseteq A_y}c_y(F)
\sum_{R\subseteq S_y}(-1)^{|R|}L_{F\cup R}(t),                 \tag{3}
\]

where for a connected graph `G` on `V`,

\[
P_G=\left\{x\in\mathbb R^n:
x_0=0,\ |x_i-x_j|\le1\text{ for every }\{i,j\}\in E(G)
\right\}
\]

and

\[
L_G(t)=\#(tP_G\cap\mathbb Z^d).
\]

Every graph \(F\cup R\) appearing with a nonzero coefficient in (3) is
connected because `F` is connected.

## 4. Reciprocity for every graph term

For connected `G`, the polytope \(P_G\) is bounded and full-dimensional in
the affine lattice \(x_0=0\). It is integral: after deleting the \(x_0\)
column, its constraint matrix consists of signed rows of a graph incidence
matrix and is totally unimodular.

For every positive integer `m`, integrality of the coordinates gives the
exact relative-interior shift

\[
\begin{aligned}
\operatorname{relint}(mP_G)\cap\mathbb Z^d
&=\{x\in\mathbb Z^d:x_0=0,\ |x_i-x_j|<m\text{ on }E(G)\}\\
&=\{x\in\mathbb Z^d:x_0=0,\ |x_i-x_j|\le m-1\text{ on }E(G)\}\\
&=(m-1)P_G\cap\mathbb Z^d.                                   \tag{4}
\end{aligned}
\]

Ehrhart-Macdonald reciprocity and (4) imply

\[
L_G(-m)=(-1)^dL_G(m-1).
\]

With \(m=t+1\), this becomes the polynomial identity

\[
L_G(-t-1)=(-1)^dL_G(t).                                      \tag{5}
\]

Equation (3) is a finite linear combination of these polynomials, all of
common dimension \(d=n-1\). Therefore

\[
N_y(-t-1)=(-1)^dN_y(t)                                      \tag{6}
\]

for every relevant vertical pattern `y`.

## 5. Removing labels

Each structure counted by the paper has exactly \(n!\) labelings. Its tiles
occupy distinct positions, so the permutation action is free. For each
labeling, the conditions \(x_0=0\) and \(\min_i y_i=0\) select one
representative of its horizontal and vertical translation class. Hence, for
every positive integer `w`,

\[
p_n(w)=\frac1{n!}\sum_yN_y(w-1).                              \tag{7}
\]

Both sides of (7) are polynomials, so (7) is a polynomial identity. With
\(t=w-1\), equations (6) and (7) give

\[
\begin{aligned}
p_n(1-w)
&=\frac1{n!}\sum_yN_y(-t-1)\\
&=(-1)^{n-1}\frac1{n!}\sum_yN_y(t)\\
&=(-1)^{n-1}p_n(w).
\end{aligned}
\]

This proves Conjecture 1. \(\square\)

## 6. Coefficient consequence

The source proves

\[
p_n(w)=\sum_{k=1}^{n}a_{n,k}\binom{w-1}{k-1}.
\]

Put \(a_k=a_{n,k+1}\) and

\[
H_n(z)=\sum_{k=0}^{n-1}a_kz^k(1-z)^{n-1-k}.
\]

The functional equation just proved is equivalent to

\[
H_n(z)=z^{n-1}H_n(z^{-1}).
\]

Thus the symmetric numerators observed in the source follow from the
connected-graph polytope decomposition.

## References

1. Anthony J. Guttmann and Rasmus M. Nilsson,
   [Counting LEGO configurations](https://arxiv.org/abs/2605.07380v1),
   arXiv:`2605.07380v1`.
2. Matthias Beck and Thomas Zaslavsky,
   [Inside-Out Polytopes](https://arxiv.org/abs/math/0309330).
3. Felix Breuer,
   [Ehrhart f*-coefficients of polytopal complexes are non-negative integers](https://arxiv.org/abs/1202.2652).

The second reference supplies the standard reciprocity framework used in
Section 4. The third gives the `f*`-basis terminology associated with the
source's coefficient expansion.
