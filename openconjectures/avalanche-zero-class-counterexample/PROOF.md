# Proof packet: the printed cycle zero-class conjecture is false

## Source boundary

For a directed cycle `C_n`, the source indexes vertices so that the
out-neighbour of `v_i` is `v_(i+1 mod n)`.  A vertex is unstable when its grain
count is at least its out-degree, and parallel firing fires all unstable
vertices simultaneously.  The avalanche complex is the downward closure of
all firing sets.

The source conjecture assumes a binary configuration `c_0` with `|c_0| > 1`
whose zero positions are

```text
[i]_k = {j : j = i (mod k), 1 <= j <= n},
```

and concludes that the avalanche complex is homotopy equivalent to
`S^(k-2)`.

## Counterexample

Set

```text
n = 3,  k = 2,  i = 2,  c_0 = (1,0,1).
```

This configuration is binary, has two grains, and its zero set is exactly
`[2]_2 = {2}`.  Thus every stated hypothesis is satisfied.

Every vertex of `C_3` has out-degree one.  At each step, each `1` fires and
moves one position forward.  The complete orbit is therefore

| time | configuration | firing set |
|---:|:---:|:---|
| 0 | `(1,0,1)` | `{v1,v3}` |
| 1 | `(1,1,0)` | `{v1,v2}` |
| 2 | `(0,1,1)` | `{v2,v3}` |
| 3 | `(1,0,1)` | repeats |

Consequently the maximal simplices of the avalanche complex are precisely

```text
{v1,v2}, {v2,v3}, {v1,v3}.
```

This is the boundary of the two-simplex on `{v1,v2,v3}`.  It is homeomorphic,
and hence homotopy equivalent, to `S^1`.  Equivalently, its ordinary Betti
numbers over any field begin `(beta_0,beta_1) = (1,1)`.  For `k = 2`, the
conjectured space is `S^0`, whose ordinary Betti numbers are `(2,0)`.
Therefore the two spaces are not homotopy equivalent, and the conjecture is
false.

## The preceding lemma

The same configuration has non-zero positions

```text
[1]_2 = {1,3}.
```

It therefore also satisfies the hypotheses of the immediately preceding
lemma labelled `lem:modcycle`, which concludes that the avalanche complex is
two disconnected points.  The triangle boundary above is connected and has
nonzero first homology, so that lemma is also false as printed.

## Failure mechanism

Ordinary congruence classes modulo `k` are not generally preserved by cyclic
wraparound modulo `n`.  In this example, advancing `{1,3}` by one directed
cycle step gives `{2,1}`, not the other residue class modulo `2`.  The source
argument implicitly treats the residue classes as though this wraparound
could not change them.  A condition such as `k | n`, or a reformulation using
cosets in the cyclic vertex group, would define a separate statement requiring
its own theorem and proof.
