# Proof of the four product inequalities

Let

\[
L=\log 2.
\]

The first four terms of the exponential series give

\[
e^{7/10}>
1+\frac7{10}+\frac{(7/10)^2}{2}+\frac{(7/10)^3}{6}
=\frac{12013}{6000}>2,
\]

and hence

\[
0<L<\frac7{10}.                                               \tag{1}
\]

For \(0<a<x\),

\[
\log\frac{x+a}{x-a}=2\operatorname{artanh}\frac ax.           \tag{2}
\]

For fixed \(x\), the function

\[
f_x(u)=\operatorname{artanh}(u/x)
\]

is convex on \([0,x)\), since

\[
f_x''(u)=\frac{2xu}{(x^2-u^2)^2}\geq0.                        \tag{3}
\]

Thus the midpoint form of the Hermite--Hadamard inequality gives

\[
f_x(m)\leq\int_{m-1/2}^{m+1/2}f_x(u)\,du.                    \tag{4}
\]

We also use the absolutely convergent expansion

\[
2\int_A^B\operatorname{artanh}(u/x)\,du
=\sum_{m\geq0}
\frac{2(B^{2m+2}-A^{2m+2})}
{(2m+1)(2m+2)x^{2m+1}},                                      \tag{5}
\]

together with

\[
\frac{2}{(2m+1)(2m+2)}\leq\frac16\qquad(m\geq1).             \tag{6}
\]

Every paired factor \((x+a)/(x-a)\) decreases with \(x\). It is therefore
enough to prove each bound at the real lower endpoint for \(k\).

## Parts (a) and (b)

For part (a), put \(r=2s\); for part (b), put \(r=2s+1\). In both cases set
\(R=r+\tfrac12\). Reindexing gives

\[
P=\prod_{i=1}^{r}\frac{k+i}{k-i},
\qquad k\geq\frac{R^2}{L}.
\]

By (2)--(4),

\[
\log P
=2\sum_{i=1}^{r}\operatorname{artanh}(i/k)
\leq2\int_{1/2}^{R}\operatorname{artanh}(u/k)\,du.            \tag{7}
\]

At \(k=R^2/L\), the \(m=0\) term in (5) is

\[
L-\frac{L}{4R^2}.                                             \tag{8}
\]

After dropping the negative lower-endpoint contribution, (6) bounds the tail
by

\[
H\leq\frac{L^3}{6R^2(1-L^2/R^2)}.                            \tag{9}
\]

Since \(R\geq5/2\), equation (1) yields

\[
2L^2<\frac{49}{50}
<3\left(1-\frac{49}{625}\right)
<3\left(1-\frac{L^2}{R^2}\right).                            \tag{10}
\]

This says that the right side of (9) is smaller than \(L/(4R^2)\), the gap in
(8). Hence \(\log P<L\) and \(P<2\). Parts (a) and (b) follow.

## Part (c)

Put \(r=2s\), \(x=k+\tfrac12\), and \(a_i=i-\tfrac12\). Then

\[
P=\prod_{i=1}^{r}\frac{x+a_i}{x-a_i},
\qquad
x\geq\frac{r^2}{L}+\frac12=\frac{D}{L},
\qquad D=r^2+\frac L2.                                       \tag{11}
\]

The \(a_i\) are the midpoints of the unit intervals partitioning \([0,r]\),
so

\[
\log P\leq2\int_0^r\operatorname{artanh}(u/x)\,du.            \tag{12}
\]

At \(x=D/L\), the linear term is \(Lr^2/D\), leaving the gap

\[
\frac{L^2}{2D}.                                               \tag{13}
\]

Since \(D\geq r^2\), the tail satisfies

\[
H\leq\frac{L^3}{6r^2(1-L^2/r^2)}.                            \tag{14}
\]

For \(r^2\geq4\), equation (1) gives

\[
LD
<\frac7{10}r^2+\frac{49}{200}
<3r^2-\frac{147}{100}
<3(r^2-L^2).                                                  \tag{15}
\]

The middle inequality follows from
\((23/10)r^2-343/200>0\). Equation (15) says exactly that the tail in (14) is
smaller than (13). Thus \(\log P<L\) and \(P<2\), proving part (c).

## Part (d)

Put \(r=2s\), \(R=r+1\), \(x=k-\tfrac12\), and
\(a_i=i+\tfrac12\). Then

\[
P=\prod_{i=1}^{r}\frac{x+a_i}{x-a_i},
\qquad
x\geq\frac{R^2}{L}-\frac12=\frac{D}{L},
\qquad D=R^2-\frac L2.                                       \tag{16}
\]

The \(a_i\) are the midpoints of the unit intervals partitioning \([1,R]\),
so

\[
\log P\leq2\int_1^R\operatorname{artanh}(u/x)\,du.            \tag{17}
\]

At \(x=D/L\), the linear term leaves the gap

\[
G=\frac{L(1-L/2)}{D}.                                        \tag{18}
\]

Since \(R\geq3\), equation (1) implies

\[
D>\frac{24}{25}R^2.                                          \tag{19}
\]

Equations (5), (6), and (19) give

\[
H\leq
\frac{L^3(25/24)^3}{6R^2(1-q)},
\qquad
q=\frac{L^2(25/24)^2}{R^2}.                                  \tag{20}
\]

Direct rational comparisons give

\[
q<\frac3{50},
\qquad
\left(\frac{25}{24}\right)^3<\frac65,                       \tag{21}
\]

and therefore

\[
\frac{L^2(25/24)^3}{6(1-q)}
<\frac{49}{470}
<\frac{13}{20}
<1-\frac L2.                                                  \tag{22}
\]

Because \(D<R^2\), equations (18), (20), and (22) imply \(H<G\). Hence
\(\log P<L\) and \(P<2\), proving part (d).

All four inequalities in Conjecture 4.1 follow. \(\square\)

## Source note

The proof of Proposition 4.2 in the source prints `22` once while restating
part (d). Conjecture 4.1, the relevant binomial inequality, and the surrounding
argument all use `2`, which is the theorem proved here.
