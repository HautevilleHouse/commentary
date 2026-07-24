# Proof packet: Class 69 is not equidistributed on involutions

## Source statement and boundary

The source defines a mesh pattern as an underlying permutation together with
shaded unit cells.  Its concluding conjecture says that the following four
patterns are equidistributed on involutions:

```text
P1 = {(1,2),(1,1),(2,1),(0,0)}
P2 = {(2,2),(0,1),(1,1),(1,0)}
P3 = {(0,2),(1,1),(2,1),(1,0)}
P4 = {(1,2),(0,1),(1,1),(2,0)}
```

All four have underlying classical pattern `12`.  A selected occurrence is
therefore a pair of positions `i<j` with values `a=sigma[i]<b=sigma[j]`.
For any other point `(k,sigma[k])`, its cell is `(x,y)` where `x` records
whether `k` is left of `i`, between `i` and `j`, or right of `j`, and `y`
records whether its value is below `a`, between `a` and `b`, or above `b`.
The pair is an occurrence exactly when no other point lies in a shaded cell.

## Complete finite domain

The involutions in `S_3` are exactly

```text
123, 132, 213, 321.
```

Applying the source definition gives:

| permutation | P1 | P2 | P3 | P4 |
|---|---:|---:|---:|---:|
| `123` | 1 | 1 | 2 | 2 |
| `132` | 0 | 2 | 1 | 1 |
| `213` | 2 | 0 | 1 | 1 |
| `321` | 0 | 0 | 0 | 0 |

Consequently,

```text
P1: {0:2, 1:1, 2:1}
P3: {0:1, 1:2, 2:1}.
```

The histograms differ, so P1 and P3 are not equidistributed on involutions.
This directly contradicts the source's involution-restricted conjecture.
The P1/P2 and P3/P4 equalities remain visible in the table and are not part
of the counterexample claim.

## Separate replay

`checkers/verify.py` first counts by position pairs, then recomputes every
count by value pairs and inverse positions.  `checkers/crosscheck.cpp` is a
separate C++ implementation that enumerates all permutations of `S_3` and
filters involutions.  Both assert the complete domain, all four row counts,
and the two different histograms.

## Remainder

The unrestricted Class-69 equidistribution problem remains unresolved here.
This finite disproof is limited to the additional restriction proposed in
the source's concluding remarks.
