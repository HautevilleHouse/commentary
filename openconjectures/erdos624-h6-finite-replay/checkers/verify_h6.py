"""Separate finite replay of a source-exact X={0,1,2,3,4,5} H(6) slice."""
from __future__ import annotations

from itertools import combinations

X = tuple(range(6))
SUBSETS = tuple(frozenset(c) for size in range(7) for c in combinations(X, size))
VALUES = (3, 2, 2, 1, 0, 4, 1, 0, 4, 4, 1, 0, 0, 1, 0, 4, 4, 0, 2, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5)


def covers(threshold: int) -> bool:
    values = dict(zip(SUBSETS, VALUES))
    return all(
        {values[source] for source in SUBSETS if source <= frozenset(target)} == set(X)
        for size in range(threshold, len(X) + 1)
        for target in combinations(X, size)
    )


def main() -> None:
    assert len(VALUES) == 2**6
    assert covers(3)
    assert covers(4)
    assert covers(5)
    assert covers(6)
    # Any Y of size 2 has only four subset images, so m<=2 is impossible for |X|=6.
    print("H(6)=3; m0/m1/m2 cardinality lower bound; m3-m6 construction passes")


if __name__ == "__main__":
    main()
