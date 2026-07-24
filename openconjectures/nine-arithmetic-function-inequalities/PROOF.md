# Proof

Write

\[
a=\varphi(n),\qquad b=\psi(n),\qquad c=\sigma(n).
\]

Throughout, `n >= 2` and `k >= 1` are integers.

## 1. Two functionals on ordered triples

For positive real numbers define

\[
P(x,y,z)=(x+y+z)\left(\frac1x+\frac1y+\frac1z\right)
\]

and

\[
N(x,y,z)=\frac{x}{y+z}+\frac{y}{x+z}+\frac{z}{x+y}.
\]

Both are invariant under a common positive scaling.

### Ordered-triple lemma

Let `0 < x <= y <= z` and `rho >= 1`.

- If `y/x >= rho`, then

  \[
  P(x,y,z)\ge P(1,\rho,\rho),\qquad
  N(x,y,z)\ge N(1,\rho,\rho).
  \]

- If `z/y >= rho`, then

  \[
  P(x,y,z)\ge P(1,1,\rho),\qquad
  N(x,y,z)\ge N(1,1,\rho).
  \]

For the first assertion normalize the triple to `(1,u,v)`, where
`rho <= u <= v`.  Exact subtraction gives

\[
P(1,u,v)-P(1,u,u)
=\frac{(u+1)(v-u)(v-1)}{uv}\ge0,
\]

\[
P(1,u,u)-P(1,\rho,\rho)
=\frac{2(u-\rho)(\rho u-1)}{\rho u}\ge0.
\]

Also

\[
N(1,u,v)-N(1,u,u)
=\frac{(v-u)Q}{2u(u+1)(u+v)(v+1)},
\]

where, on putting `d=v-u`,

\[
Q=2d^2u+4du^2+d(u-1)+(3u+1)(u-1)\ge0.
\]

Finally,

\[
N(1,u,u)-N(1,\rho,\rho)
=\frac{(u-\rho)(3\rho u-\rho-u-1)}
       {2\rho u(\rho+1)(u+1)}\ge0,
\]

because

\[
3\rho u-\rho-u-1
=(\rho-1)(u-1)+2(\rho u-1)\ge0.
\]

For the second assertion normalize the triple to `(s,1,t)`, where
`0<s<=1<=rho<=t`.  Then

\[
P(s,1,t)-P(1,1,t)
=\frac{(t-s)(t+1)(1-s)}{ts}\ge0,
\]

\[
P(1,1,t)-P(1,1,\rho)
=\frac{2(t-\rho)(\rho t-1)}{\rho t}\ge0.
\]

Similarly,

\[
N(s,1,t)-N(1,1,t)
=\frac{(1-s)R}{2(t+1)(t+s)(s+1)},
\]

where `d=t-1` and `e=1-s` give

\[
R=d^3+4d^2+3d+2e+(1-e)d^2+(1-e)d+2e(1-e)\ge0.
\]

Moreover,

\[
N(1,1,t)-N(1,1,\rho)
=\frac{(t-\rho)(\rho t+\rho+t-3)}
       {2(\rho+1)(t+1)}\ge0,
\]

since

\[
\rho t+\rho+t-3
=(\rho-1)(t-1)+2(\rho-1)+2(t-1)\ge0.
\]

This proves the ordered-triple lemma.

## 2. Arithmetic-function separation

The prime-power formulas imply

\[
0<a\le b\le c,
\qquad a\le n-1,
\qquad b\ge n+1.
\]

Therefore

\[
\frac ba\ge\frac{n+1}{n-1}. \tag{1}
\]

We also need the following gap inequality.

### Gap lemma

For every `n >= 2`,

\[
n\bigl(\psi(n)-\varphi(n)\bigr)
\ge \varphi(n)+\sigma(n). \tag{2}
\]

Equality occurs precisely when `n` is prime.

Define

\[
D(n)=n(\psi(n)-\varphi(n))-\varphi(n)-\sigma(n).
\]

We induct on the number of prime factors counted with multiplicity.  If `p`
is prime, `\varphi(p)=p-1` and `\psi(p)=\sigma(p)=p+1`, so `D(p)=0`.

Suppose `m>=2`, and put

\[
A=\varphi(m),\qquad B=\psi(m),\qquad C=\sigma(m).
\]

If a prime `p` does not divide `m`, multiplicativity gives

\[
\varphi(pm)=(p-1)A,\quad
\psi(pm)=(p+1)B,\quad
\sigma(pm)=(p+1)C.
\]

Consequently

\[
\begin{aligned}
D(pm)-p^2D(m)
={}&pm(A+B)+(p^2-p+1)A\\
&+(p^2-p-1)C\ge0.
\end{aligned}
\]

If `p` divides `m`, write `m=p^e r`, with `p` not dividing `r`, and put
`E=\sigma(r)`.  The prime-power formulas give

\[
\varphi(pm)=pA,\quad
\psi(pm)=pB,\quad
\sigma(pm)=pC+E.
\]

Thus

\[
D(pm)-p^2D(m)=p(p-1)(A+C)-E\ge0,
\]

because `C=\sigma(p^e)E>=E` and `p(p-1)>=2`.  In the fresh-prime case the
first summand is already positive.  In the repeated-prime case, `A>0`,
`C>=E>0`, and `p(p-1)>=2`, so that increment is positive as well.  Thus
equality survives only at the prime base.  This proves (2).

Rearranging (2) yields the pair-sum separation

\[
\frac{b+c}{a+c}\ge\frac{n+1}{n}. \tag{3}
\]

## 3. The nine reductions

Put

\[
q=\frac{n+1}{n-1}.
\]

The exact reductions are as follows.

| Conjecture | Functional and ordered triple | Separation |
|---|---|---|
| 1 | `P(a^k,b^k,c^k)` | left, `rho_1=q^k` |
| 2 | `P((a+b)^k,(a+c)^k,(b+c)^k)` | right, `rho_2=((n+1)/n)^k` |
| 3 | `N(a^k,b^k,c^k)` | left, `rho_1` |
| 4 | `P(a^k(b+c),b^k(a+c),c^k(a+b))` | left, `rho_4=n(n+1)^(k-1)/(n-1)^k` |
| 5 | `P(a^k(b^k+c^k),b^k(a^k+c^k),c^k(a^k+b^k))` | left, `rho_5=((n-1)^k+(n+1)^k)/(2(n-1)^k)` |
| 6 | `N(1/c^k,1/b^k,1/a^k)` | right, `rho_1` |
| 7 | `N((a+b)^k,(a+c)^k,(b+c)^k)` | right, `rho_2` |
| 8 | `N(a^k(b+c),b^k(a+c),c^k(a+b))` | left, `rho_4` |
| 9 | `N(a^k(b^k+c^k),b^k(a^k+c^k),c^k(a^k+b^k))` | left, `rho_5` |

Rows 1 and 3 follow from (1).  Rows 2 and 7 follow from (3).

For rows 4 and 8 put `u=b/a` and `v=c/a`.  Then `q<=u<=v`, and

\[
\frac{b^k(a+c)}{a^k(b+c)}
=u^k\frac{1+v}{u+v}
\ge u^{k-1}\frac{1+u}{2}
\ge q^{k-1}\frac{1+q}{2}=\rho_4.
\]

The first inequality is equivalent, after clearing positive denominators, to
`(u-1)(v-u)>=0`.  The first argument is therefore at most the second.  The
second is at most the third because

\[
v^k(1+u)-u^k(1+v)
=(v^k-u^k)+uv(v^{k-1}-u^{k-1})\ge0.
\]

Hence the three displayed arguments of `P` or `N` are ordered.

For rows 5 and 9 apply that calculation to
`u=(b/a)^k` and `v=(c/a)^k`.  It gives

\[
\frac{b^k(a^k+c^k)}{a^k(b^k+c^k)}
=u\frac{1+v}{u+v}
\ge\frac{1+u}{2}\ge\rho_5.
\]

For row 6, set `A=a^k`, `B=b^k`, `C=c^k`.  Then

\[
N(1/C,1/B,1/A)
=\frac{AB}{C(A+B)}+\frac{AC}{B(A+C)}+\frac{BC}{A(B+C)},
\]

which is exactly its left-hand side, and `(1/A)/(1/B)=B/A>=rho_1`.

Finally,

\[
P(1,\rho,\rho)=P(1,1,\rho)
=5+2\rho+\frac2\rho,
\]

\[
N(1,\rho,\rho)=\frac1{2\rho}+\frac{2\rho}{1+\rho},
\qquad
N(1,1,\rho)=\frac\rho2+\frac2{1+\rho}.
\]

Substitution of `rho_1,rho_2,rho_4,rho_5` reproduces exactly the nine
right-hand sides in the source.  The ordered-triple lemma therefore proves
all nine conjectures.

If `n` is prime, `a=n-1` and `b=c=n+1`, so equality holds throughout.  If
`n` is composite, both (1) and the applicable form of the gap separation are
strict.  Thus every applicable ordered-triple bound is strict.  Equality in
any of the nine inequalities occurs precisely for prime `n`.
