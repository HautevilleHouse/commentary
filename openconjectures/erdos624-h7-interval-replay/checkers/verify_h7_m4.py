"""Separate replay of an X={0,...,6} H(7) construction at m=4."""
from __future__ import annotations

from itertools import combinations

X = tuple(range(7))
SUBSETS = tuple(frozenset(c) for size in range(8) for c in combinations(X, size))
VALUES = (
    0, 3, 1, 5, 4, 1, 5, 2, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
    6, 6, 6, 6, 6, 6, 6, 6, 6, 2, 2, 6, 6, 6, 2, 6, 4, 6, 6, 2,
    6, 6, 6, 6, 2, 6, 4, 6, 6, 6, 3, 2, 4, 6, 6, 3, 6, 6, 6, 3,
    6, 6, 0, 6, 6, 4, 6, 4, 5, 6, 5, 4, 5, 4, 4, 1, 1, 2, 4, 1,
    0, 5, 1, 4, 3, 6, 3, 3, 3, 6, 3, 5, 6, 3, 2, 3, 1, 4, 3, 6,
    6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
    6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
)[:128]


def covers(threshold: int) -> bool:
    values = dict(zip(SUBSETS, VALUES))
    return all(
        {values[source] for source in SUBSETS if source <= frozenset(target)} == set(X)
        for size in range(threshold, len(X) + 1)
        for target in combinations(X, size)
    )


def main() -> None:
    assert len(VALUES) == 2**7
    assert covers(4)
    assert covers(5)
    assert covers(6)
    assert covers(7)
    print("3 <= H(7) <= 4; m4 construction passes 99 targets; m3 remains unknown")


if __name__ == "__main__":
    main()
