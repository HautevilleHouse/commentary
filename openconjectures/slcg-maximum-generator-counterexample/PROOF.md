# Proof packet: the printed S-LCG maximum-generator formula is false

## 1. Source-exact setup

For a positive integer `n`, the source defines the S-LCG map on residues
modulo

\[
M_n=2^n+1
\]

by

\[
f_n(x)=2x+1\pmod {M_n}.
\]

Because multiplication by `2` is invertible modulo the odd number `M_n`,
this map is a permutation.  The source defines the generator of a cycle to be
its minimum element and writes `G_n` for the set of these cycle generators.
Thus

\[
\alpha_{\max}^{(n)}=\max G_n.
\]

For odd `n`, the source conjectures

\[
P_n=\frac43\left(4^{(n-3)/2}-1\right)
\]

and prints the recurrence

\[
P_{2k+1}=4P_{2k-1}+4,\qquad P_3=0.
\]

## 2. A two-line counterexample at `n = 7`

Here `M_7=129`.  Direct calculation gives

\[
f_7(42)=2\cdot42+1=85
\]

and

\[
f_7(85)=2\cdot85+1=171\equiv42\pmod{129}.
\]

Hence `C={42,85}` is a cycle.  Its minimum is `42`, so `42` is a generator
under the source definition.  Consequently

\[
\alpha_{\max}^{(7)}\ge 42.
\]

Both `42` and `85` lie in the source's `n`-bit range
`{0,1,...,2^7-1}`.  The witness therefore does not depend on whether the
extra residue `2^7` in `Z_129` is included in the implementation state
space; the source is not consistent about that boundary.

But the conjectured value is

\[
P_7=\frac43(4^2-1)=20.
\]

Therefore `alpha_max^(7)` cannot equal the conjectured value, and the
universal conjecture is false.

This discrepancy is visible inside the source itself: the source's `n = 7`
state-transition table includes the row `Gen. 42 | 85`, while its later table
reports `alpha_max^(7)=20`.

## 3. The obstruction is an infinite family

Let `n >= 3` be odd and define

\[
a_n=\frac{2^n-2}{3},\qquad
b_n=\frac{2^{n+1}-1}{3}.
\]

These are integers: odd `n` gives `2^n = 2 (mod 3)`, while even `n+1`
gives `2^(n+1) = 1 (mod 3)`.  They lie in the `n`-bit state range and
`a_n<b_n`.

Now

\[
2a_n+1=b_n,
\]

so `f_n(a_n)=b_n`.  Also

\[
2b_n+1
=\frac{2^{n+2}+1}{3}
=\left(2^n+1\right)+\frac{2^n-2}{3}
=M_n+a_n,
\]

so `f_n(b_n)=a_n`.  Thus `{a_n,b_n}` is a two-cycle whose generator is
`a_n`.

For odd `n`, the conjectured expression rewrites as

\[
P_n=\frac{2^{n-1}-4}{3}.
\]

The gap is

\[
a_n-P_n
=\frac{2^{n-1}+2}{3}>0.
\]

Therefore `alpha_max^(n) >= a_n > P_n` for every odd `n >= 3`.  The
counterexample at `n=7` is the smallest instance that simultaneously lies in
the printed recurrence range and appears explicitly in both conflicting
source tables.

## 4. Verification boundary

The Python checker verifies the symbolic integer identities through a broad
odd-parameter range and enumerates every cycle for odd
`n=3,5,...,19`.  The Lean/mathlib file certifies the complete `n=7` arithmetic
counterexample.  Neither finite replay is used as a substitute for the
general algebra above; each is a separate transcription and arithmetic
check.

No statement is made here about a repaired conjecture that discards cycles of
length less than `2n` or otherwise changes the source definition of a valid
generator.
