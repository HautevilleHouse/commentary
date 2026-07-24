# Proof

Let `M={1,e,x,y,z}`. The element `1` is the global identity. The subset
`{e,x,y,z}` is a Klein four-group with identity `e`:

```text
x^2=y^2=z^2=e,   xy=z, xz=y, yz=x,   e^2=e.
```

For a nonzero heap `r`, define `h(r)=e,x,y,z` when `r mod 4` is `1,2,3,0`,
respectively; the empty sum maps to `1`. The loss set is `{e}`.

For a finite sum `P` of nonzero heaps, let `phi(P)` be the product of the heap
images. We prove by induction on total heap size that `P` is a misère
P-position exactly when `phi(P)=e`. The empty sum is N and maps to `1`.

A move to zero loses immediately, so it is not a winning option. For every safe
move, the transition multiplier in the Klein-group part is one of `x,y,z`,
never `e`:

```text
old factor   d=1       d=2       d=3
e (r=1 mod4) z         y         x
x (r=2 mod4) x         y         z
y (r=3 mod4) z         y         x
z (r=0 mod4) x         y         z
```

If `phi(P)=e`, every safe option therefore has image different from `e`, and
the induction hypothesis makes every safe option N. Hence `P` is P.

If `phi(P)=g` for `g in {x,y,z}`, a safe move with multiplier `g` always exists:

* for `g=x`, use a residue-2 heap with `d=1`; if none exists, the product `x`
  forces a residue-0 heap, whose `d=1` move has multiplier `x`;
* for `g=y`, use a residue-3 heap with `d=2`; if none exists, the product `y`
  forces a residue-0 heap, whose `d=2` move has multiplier `y`;
* for `g=z`, use a residue-0 heap with `d=3`; if none exists, the product `z`
  forces a residue-3 heap, whose `d=1` move has multiplier `z`.

The smallest heaps in these cases are `2`, `3`, and `4`, so the indicated moves
are safe. The resulting position has product `g^2=e` and smaller total size,
so it is P by induction. Thus the original position is N. This proves the
outcome rule for every finite sum.

If two positions have the same image in `M`, adjoining any context multiplies
both images by the same element, so the outcome rule gives the same result.
Distinct elements are separated by finite contexts: `1` versus `e` by the
empty context; `e` versus `x,y,z` by the empty context; and `x,y,z` pairwise by
contexts `x`, `y`, and `z` (for example, `x*x=e` is losing while `y*x=z` is
winning). Therefore these five elements are exactly the misère quotient classes.

This proves the exact `m=3` quotient and does not settle the source's general
all-`m` conjecture.
