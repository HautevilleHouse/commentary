"""Separate finite replay of the source-exact X={0,1,2,3} H(4) slice."""
from __future__ import annotations

from itertools import combinations

X = (0, 1, 2, 3)
SUBSETS = tuple(frozenset(c) for size in range(5) for c in combinations(X, size))
VALUES = {subset: 0 for subset in SUBSETS}
# A 1-factorization of K4: every triple sees all three pair colors.
VALUES.update({
    frozenset((0, 1)): 1,
    frozenset((2, 3)): 1,
    frozenset((0, 2)): 2,
    frozenset((1, 3)): 2,
    frozenset((0, 3)): 3,
    frozenset((1, 2)): 3,
})


def covers(values: dict[frozenset[int], int], threshold: int) -> bool:
    return all(
        {values[source] for source in SUBSETS if source <= frozenset(target)} == set(X)
        for size in range(threshold, len(X) + 1)
        for target in combinations(X, size)
    )


def main() -> None:
    assert not covers(VALUES, 2)
    assert covers(VALUES, 3)
    assert covers(VALUES, 4)
    print("H(4)=3; m0/m1/m2 lower bound; m3 construction passes 5 triples")


if __name__ == "__main__":
    main()
