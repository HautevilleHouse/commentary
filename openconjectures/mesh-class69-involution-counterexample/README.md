# Class-69 involution-restricted counterexample

This packet gives a source-exact finite counterexample to the additional
involution-restricted conjecture in the concluding remarks of Fang, Fu,
Kitaev, Li, Su, and Sun, *On mesh patterns of short length: Equidistribution
and enumeration* (arXiv:2606.14367v1).

The source lists four length-2 mesh patterns with underlying pattern `12`.
For a shaded cell `(x,y)`, `x=0,1,2` means left of, between, or right of the
selected positions, and `y=0,1,2` means below, between, or above the selected
values.  The source conjectures that their occurrence-count distributions
are equal after restricting the domain to involutions.

For the complete domain of involutions in `S_3`, the exact occurrence rows are:

```text
permutation   P1 P2 P3 P4
123             1  1  2  2
132             0  2  1  1
213             2  0  1  1
321             0  0  0  0
```

Thus P1 has histogram `{0:2, 1:1, 2:1}`, while P3 has
`{0:1, 1:2, 2:1}`.  They are not equidistributed on involutions, so the
source's added restricted conjecture is false.  P2 matches P1 and P4 matches
P3, consistent with the source's reverse-complement observation.

## Replay

From the repository root:

```bash
python3 openconjectures/mesh-class69-involution-counterexample/checkers/verify.py
clang++ -std=c++20 -Wall -Wextra -pedantic -O2 \
  openconjectures/mesh-class69-involution-counterexample/checkers/crosscheck.cpp \
  -o /tmp/mesh_class69_counterexample && /tmp/mesh_class69_counterexample
```

The Python checker uses position-pair enumeration and repeats
the count by value pairs and inverse positions.  The C++ checker enumerates
all six permutations directly and applies the cell definition separately.

## Scope and status

This packet refutes only the source's additional conjecture restricted to
involutions. It does not resolve the unrestricted Class-69 equidistribution
question.

All Rights Reserved - No License Granted.  Cite this packet together with the
source version above.
