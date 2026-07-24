# Proof of the \(Q_{01}\) coefficient classification

For distinct primes \(p,q\), set

\[
F_{p,q}(x)=\frac{Q_{01}(x)}x=\Phi_q(x)^2\Phi_{p^2q}(x).
\]

Multiplication by \(x\) shifts coefficients, so \(Q_{01}\) and \(F_{p,q}\)
have the same coefficient signs.

## A coefficient formula

Let

\[
A_q(x)=\Phi_q(x)^2=(1+x+\cdots+x^{q-1})^2
       =\sum_{n=0}^{2q-2}a_nx^n.
\]

Extend \(a_n\) by zero outside \([0,2q-2]\). Then

\[
a_n=
\begin{cases}
n+1,&0\le n<q,\\
2q-1-n,&q\le n\le2q-2,\\
0,&\text{otherwise}.
\end{cases}                                                   \tag{1}
\]

The cyclotomic product formula gives

\[
\Phi_{p^2q}(x)
=\frac{(1-x^{p^2q})(1-x^p)}{(1-x^{p^2})(1-x^{pq})}.           \tag{2}
\]

Consequently, for every \(n<pq\),

\[
[x^n]F_{p,q}(x)
=\sum_{j\ge0}\bigl(a_{n-jp^2}-a_{n-p-jp^2}\bigr).           \tag{3}
\]

Only finitely many terms in (3) are nonzero.

## The case \(p=2\)

Here \(q\) is odd. For \(n<2q\), equation (3) becomes

\[
c_n:=[x^n]F_{2,q}(x)
=\sum_{j=0}^{\lfloor n/2\rfloor}(-1)^ja_{n-2j},
\qquad c_n+c_{n-2}=a_n,                                      \tag{4}
\]

with \(c_{-2}=c_{-1}=0\).

Write \(q=2m+1\). For \(0\le n<q\), the sum in (4) alternates through a
strictly decreasing sequence of positive integers, so \(c_n>0\). In fact,

\[
c_{2s}=s+1,
\qquad
c_{2s+1}=2\left(\left\lfloor\frac{s}{2}\right\rfloor+1\right). \tag{5}
\]

For the remaining first-half coefficients, put \(d_r=c_{q+r}\), where
\(0\le r\le2m-1\). Formula (5) gives

\[
d_{-2}=2\left\lceil\frac m2\right\rceil,
\qquad d_{-1}=m+1.
\]

Because \(a_{q+r}=2m-r\), recurrence (4) becomes

\[
d_r=2m-r-d_{r-2}.                                            \tag{6}
\]

Solving its two parity chains yields

\[
d_{2t}=
\begin{cases}
2\lfloor m/2\rfloor-t,&t\text{ even},\\
2\lceil m/2\rceil-t-1,&t\text{ odd},
\end{cases}                                                   \tag{7}
\]

and

\[
d_{2t+1}=
\begin{cases}
m-2-t,&t\text{ even},\\
m-t,&t\text{ odd}.
\end{cases}                                                   \tag{8}
\]

All entries in (7) are nonnegative. If \(m\) is even, all entries in (8)
are nonnegative. If \(m\) is odd, the final entry is

\[
d_{2m-1}=-1,                                                  \tag{9}
\]

and every earlier entry is nonnegative.

The polynomial \(F_{2,q}\) is reciprocal and has degree \(4q-4\), so its
coefficients are symmetric about degree \(2q-2\), the range covered above.
Therefore

\[
F_{2,q}\text{ is coefficientwise nonnegative}
\quad\Longleftrightarrow\quad
q\equiv1\pmod4.                                              \tag{10}
\]

## The case of odd \(p\)

Assume \(p\) is odd. Put

\[
P=p^2,qquad D=2q-2,qquad n_0=q+\frac{p-1}{2}.
\]

### Range 1: \(p\ge2q-1\)

Take \(n=p\). Since \(n<P\), only \(j=0\) contributes to (3). Also
\(a_p=0\) and \(a_0=1\), so

\[
[x^p]F_{p,q}=-1.                                             \tag{11}
\]

### Range 2: \(p<2q-1\) and \(n_0<P\)

Set \(k=n_0-p=q-(p+1)/2\). Formula (1) gives

\[
a_{n_0}=q-\frac{p+1}{2},
\qquad
a_k=q-\frac{p-1}{2}.
\]

Again only \(j=0\) contributes to (3), and hence

\[
[x^{n_0}]F_{p,q}=-1.                                        \tag{12}
\]

### Range 3: \(n_0\ge P\)

For \(r\in\mathbb Z/P\mathbb Z\), define

\[
S_r=\sum_{\substack{t\in\mathbb Z\\t\equiv r\ (\mathrm{mod}\ P)}}a_t.
\tag{13}
\]

If \(D+p\le n<pq\), equation (3) becomes

\[
[x^n]F_{p,q}=S_{n\bmod P}-S_{(n-p)\bmod P}.                 \tag{14}
\]

The sequence \(S_r\) cannot be invariant under translation by \(p\). To
prove this, reduce \(A_q(x)\) modulo \(x^P-1\):

\[
R(x)=\sum_{r=0}^{P-1}S_rx^r
\equiv(1+x+\cdots+x^{q-1})^2\pmod{x^P-1}.                   \tag{15}
\]

If \(S_{r+p}=S_r\) for every \(r\), then

\[
R(x)=H(x)(1+x^p+\cdots+x^{(p-1)p})
\]

for some \(H\). At a primitive \(p^2\)-th root \(\zeta\), the right side
vanishes, while (15) gives

\[
R(\zeta)=\left(\frac{1-\zeta^q}{1-\zeta}\right)^2\ne0,
\]

because \(p\nmid q\). This is a contradiction.

Thus the cyclic differences \(\Delta_r=S_r-S_{r-p}\) are not all zero.
Their sum over \(r\pmod P\) is zero, so at least one \(\Delta_r\) is
strictly negative.

The integer interval

\[
I=[D+p,pq-1]\cap\mathbb Z
\]

has cardinality

\[
|I|=(p-2)q-p+2.                                              \tag{16}
\]

The present range gives \(q\ge p^2-(p-1)/2\). If \(p=3\), primality and
\(q\ne3\) imply \(q\ge11\), whence \(|I|=q-1\ge10>P\). If \(p\ge5\),
substitution into (16) gives \(|I|\ge P\). Hence \(I\) meets every residue
class modulo \(P\). Choose \(n\in I\) whose residue has
\(\Delta_r<0\). Equation (14) yields

\[
[x^n]F_{p,q}<0.                                              \tag{17}
\]

The three odd-\(p\) ranges are exhaustive. Combining (10)--(12) and (17)
proves

\[
Q_{01}(x)\text{ has nonnegative coefficients}
\quad\Longleftrightarrow\quad
p=2\text{ and }q\equiv1\pmod4.\qquad\square
\]

## Replay boundary

The companion checker tests the closed formulas, the three odd-\(p\) witness
branches, and a separate exact implementation of cyclotomic polynomials. The
finite grids support the algebra and detect transcription errors. The proof
above supplies the arbitrary-parameter closure.
