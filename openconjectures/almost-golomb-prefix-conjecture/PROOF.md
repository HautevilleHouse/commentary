# Proof of the Prefix Conjecture

Fix `r >= 3` and write `a(n)=a_r(n)`.  Extend `a` by `a(n)=0` for
`n <= 0`, as in the source.  Let `N_r(m)` be the length of the run of the
value `m`.

We use two results already proved in the source:

1. `a` is nondecreasing, every positive integer occurs in one run, and for
   `m >= 3` the run of `m` has the stated source endpoints.
2. For `m >= 3`, telescoping those endpoints gives

   \[
   N_r(m)=a(m+1)-a(m+1-r). \tag{1}
   \]

For `3 <= m <= r-1`, the second term in (1) has nonpositive index.  Hence

\[
N_r(m)=a(m+1). \tag{2}
\]

## Initial runs

The source's initial-prefix argument gives `a(1)=1` and says that the value
`2` occupies positions `2` through `S_3-1`, where

\[
S_3=a(3)+a(2)+a(1)
\]

because `r >= 3`.  It also gives `S_3 >= 4`.  Thus position `3` still lies in
the run of `2`, so `a(3)=2`.  Consequently `S_3=2+2+1=5`.  The initial runs
are therefore

\[
1,\quad 2,2,2,
\]

and the run of `3` begins at position `5`.

Golomb's sequence begins

\[
1,\quad 2,2,\quad 3,3,\quad 4,4,4,\ldots
\]

and, by definition, the run of every value `m` has length `G(m)`.  Compared
with `G`, the almost Golomb prefix has one extra `2`.  Thus the beginning of
the run of `3` is shifted from position `4` to position `5`.

## Induction over runs

We prove

\[
a(n)=G(n-1)\qquad(3\le n\le r). \tag{3}
\]

The cases `n=3` and, when applicable, `n=4` follow from the initial runs:
both sides equal `2`.

Let `5 <= n <= r`, and assume (3) at every smaller index at least `3`.
Put

\[
v=G(n-1).
\]

For `n-1 >= 4`, one has `v < n-1`; hence `3 <= v <= n-2`.  Equation (2)
and the induction hypothesis at index `v+1` give

\[
N_r(v)=a(v+1)=G(v). \tag{4}
\]

The same argument applies to every run from `3` through `v`.  Therefore all
those runs have exactly their Golomb lengths.  Since the run of `2` had one
extra term, the entire run of `v` in `a` is the run of `v` in `G` shifted one
position to the right.

The position `n-1` lies in the run of `v` in `G` by the definition of `v`.
Hence position `n` lies in the shifted run of `v` in `a`.  Thus

\[
a(n)=v=G(n-1),
\]

which completes the induction and proves (3).  Taking `n=r` yields

\[
\boxed{a_r(r)=G(r-1)}.
\]

Finally, for `r >= 4`, substituting `m=r-1` into (1) gives

\[
N_r(r-1)=a_r(r)-a_r(0)=G(r-1).
\]

This is the boundary identity used by the source.  Proving that this boundary
run is the **largest** run is the separate Domination Lemma and is not part of
this proof.
