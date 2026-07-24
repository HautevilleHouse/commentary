#!/usr/bin/env python3
"""Exact two-route replay of the Class-69 S_3 counterexample."""

from collections import Counter
from itertools import permutations

P1 = frozenset({(1, 2), (1, 1), (2, 1), (0, 0)})
P2 = frozenset({(2, 2), (0, 1), (1, 1), (1, 0)})
P3 = frozenset({(0, 2), (1, 1), (2, 1), (1, 0)})
P4 = frozenset({(1, 2), (0, 1), (1, 1), (2, 0)})
PATTERNS = (P1, P2, P3, P4)


def is_involution(sigma):
    return all(sigma[sigma[i] - 1] == i + 1 for i in range(len(sigma)))


def by_positions(sigma, shaded):
    count = 0
    for i in range(len(sigma)):
        for j in range(i + 1, len(sigma)):
            a, b = sigma[i], sigma[j]
            if a >= b:
                continue
            valid = True
            for k, value in enumerate(sigma):
                if k in (i, j):
                    continue
                x = 0 if k < i else 1 if k < j else 2
                y = 0 if value < a else 1 if value < b else 2
                if (x, y) in shaded:
                    valid = False
                    break
            count += valid
    return count


def by_values(sigma, shaded):
    position = {value: i for i, value in enumerate(sigma)}
    count = 0
    for a in range(1, len(sigma) + 1):
        for b in range(a + 1, len(sigma) + 1):
            i, j = position[a], position[b]
            if i >= j:
                continue
            valid = True
            for value, k in position.items():
                if value in (a, b):
                    continue
                x = 0 if k < i else 1 if k < j else 2
                y = 0 if value < a else 1 if value < b else 2
                if (x, y) in shaded:
                    valid = False
                    break
            count += valid
    return count


def main():
    involutions = [
        sigma for sigma in permutations(range(1, 4)) if is_involution(sigma)
    ]
    assert involutions == [(1, 2, 3), (1, 3, 2), (2, 1, 3), (3, 2, 1)]
    rows = []
    histograms = [Counter() for _ in PATTERNS]
    for sigma in involutions:
        counts = tuple(by_positions(sigma, pattern) for pattern in PATTERNS)
        assert counts == tuple(by_values(sigma, pattern) for pattern in PATTERNS)
        rows.append(("".join(map(str, sigma)), counts))
        for i, count in enumerate(counts):
            histograms[i][count] += 1
    assert histograms[0] == Counter({0: 2, 1: 1, 2: 1})
    assert histograms[1] == histograms[0]
    assert histograms[2] == Counter({0: 1, 1: 2, 2: 1})
    assert histograms[3] == histograms[2]
    assert histograms[0] != histograms[2]
    print("involutions_n3=4")
    for permutation, counts in rows:
        print(permutation, counts)
    for i, histogram in enumerate(histograms, 1):
        print(f"P{i}_histogram={dict(sorted(histogram.items()))}")
    print("counterexample=Class69 P1 versus P3 on involutions of size 3")


if __name__ == "__main__":
    main()
