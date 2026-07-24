"""Separate replay of a finite X={0,1,2,3,4} H(5) construction."""
from __future__ import annotations

from itertools import combinations

X = (0, 1, 2, 3, 4)
SUBSETS = tuple(frozenset(c) for size in range(6) for c in combinations(X, size))
VALUES = {
    frozenset(): 0,
    frozenset((0,)): 1, frozenset((1,)): 2, frozenset((2,)): 1,
    frozenset((3,)): 2, frozenset((4,)): 3,
    frozenset((0, 1)): 1, frozenset((0, 2)): 2, frozenset((0, 3)): 3,
    frozenset((0, 4)): 4, frozenset((1, 2)): 3, frozenset((1, 3)): 1,
    frozenset((1, 4)): 4, frozenset((2, 3)): 4, frozenset((2, 4)): 4,
    frozenset((3, 4)): 4,
}
VALUES.update({subset: 4 for subset in SUBSETS if len(subset) >= 3})


def covers(threshold: int) -> bool:
    return all(
        {VALUES[source] for source in SUBSETS if source <= frozenset(target)} == set(X)
        for size in range(threshold, len(X) + 1)
        for target in combinations(X, size)
    )


def main() -> None:
    assert len(VALUES) == 2**5
    assert covers(3)
    assert covers(4)
    assert covers(5)
    # For m <= 2, any Y of size 2 has at most four subset images, fewer than |X|=5.
    print("H(5)=3; m0/m1/m2 cardinality lower bound; m3/m4/m5 construction passes")


if __name__ == "__main__":
    main()
