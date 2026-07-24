#!/usr/bin/env python3
"""Separate finite replay of the exact m=3 quotient claim."""
from functools import lru_cache
from itertools import combinations_with_replacement


def mul(a, b):
    if a == 0:
        return b
    if b == 0:
        return a
    if a == 1:
        return b
    if b == 1:
        return a
    if a == b:
        return 1
    return ({2, 3, 4} - {a, b}).pop()


def heap_class(r):
    return {1: 1, 2: 2, 3: 3, 0: 4}[r % 4]


@lru_cache(None)
def source_n_position(pos):
    pos = tuple(sorted(x for x in pos if x))
    if not pos:
        return True
    for i, heap in enumerate(pos):
        for d in (1, 2, 3):
            if d > heap or d == heap:
                continue
            nxt = list(pos)
            nxt[i] = heap - d
            nxt = tuple(sorted(x for x in nxt if x))
            if not source_n_position(nxt):
                return True
    return False


def image(pos):
    out = 0
    for heap in pos:
        out = mul(out, heap_class(heap))
    return out


def main():
    for a in range(5):
        for b in range(5):
            for c in range(5):
                assert mul(mul(a, b), c) == mul(a, mul(b, c))
    max_heap, max_count = 30, 6
    checked = 0
    for count in range(max_count + 1):
        for pos in combinations_with_replacement(range(1, max_heap + 1), count):
            assert source_n_position(pos) == (image(pos) != 1), (pos, image(pos))
            checked += 1
    reps = [(), (1,), (2,), (3,), (4,)]
    contexts = [c for h in range(5) for c in combinations_with_replacement(range(1, 13), h)]
    signatures = [tuple(source_n_position(tuple(sorted(rep + c))) for c in contexts) for rep in reps]
    assert len(set(signatures)) == 5
    print(f"associativity=PASS; positions_checked={checked}; classes=5; separation=PASS")
    print("RESULT: PASS")


if __name__ == "__main__":
    main()
