#!/usr/bin/env python3
"""Verify the exact GLMY counterexample for C_13^{1,4,6}."""

from collections import defaultdict
from hashlib import sha256
from itertools import permutations, product
import json
from pathlib import Path


N = 13
STEPS = (1, 4, 6)
MODULUS = 101


def add_term(chain, key, coefficient):
    chain[key] += coefficient
    if chain[key] == 0:
        del chain[key]


def sign_of_permutation(word):
    inversions = sum(
        word[left] > word[right]
        for left in range(len(word))
        for right in range(left + 1, len(word))
    )
    return -1 if inversions % 2 else 1


def forbidden_face_rows(degree):
    """Return the invariant forbidden-face matrix for allowed step words."""
    words = list(product(STEPS, repeat=degree))
    rows = {}
    for column, word in enumerate(words):
        for position in range(1, degree):
            merged = (word[position - 1] + word[position]) % N
            if merged == 0 or merged in STEPS:
                continue
            face = word[: position - 1] + (merged,) + word[position + 1 :]
            row = rows.setdefault(face, [0] * len(words))
            row[column] += (-1) ** position
    return words, rows


def modular_rank_after_insert(pivots, row):
    reduced = [value % MODULUS for value in row]
    while True:
        pivot = next((index for index, value in enumerate(reduced) if value), None)
        if pivot is None:
            return False
        if pivot not in pivots:
            inverse = pow(reduced[pivot], -1, MODULUS)
            pivots[pivot] = [value * inverse % MODULUS for value in reduced]
            return True
        factor = reduced[pivot]
        reduced = [
            (value - factor * pivots[pivot][index]) % MODULUS
            for index, value in enumerate(reduced)
        ]


def full_rank_minor(rows, width):
    pivots = {}
    selected = []
    for face, row in rows.items():
        if modular_rank_after_insert(pivots, row):
            selected.append((face, row))
        if len(selected) == width:
            return selected
    raise AssertionError("forbidden-face matrix did not reach full column rank")


def bareiss_determinant(matrix):
    """Compute an integer determinant with fraction-free elimination."""
    matrix = [row[:] for row in matrix]
    size = len(matrix)
    previous_pivot = 1
    sign = 1
    for column in range(size - 1):
        pivot_row = next(
            (row for row in range(column, size) if matrix[row][column] != 0), None
        )
        if pivot_row is None:
            return 0
        if pivot_row != column:
            matrix[column], matrix[pivot_row] = matrix[pivot_row], matrix[column]
            sign *= -1
        pivot = matrix[column][column]
        for row in range(column + 1, size):
            for entry in range(column + 1, size):
                numerator = (
                    matrix[row][entry] * pivot
                    - matrix[row][column] * matrix[column][entry]
                )
                assert numerator % previous_pivot == 0
                matrix[row][entry] = numerator // previous_pivot
        for row in range(column + 1, size):
            matrix[row][column] = 0
        previous_pivot = pivot
    return sign * matrix[-1][-1]


def split_boundary(chain):
    allowed = defaultdict(int)
    forbidden = defaultdict(int)
    for (start, word), coefficient in chain.items():
        degree = len(word)
        add_term(allowed, ((start + word[0]) % N, word[1:]), coefficient)
        add_term(allowed, (start, word[:-1]), coefficient * (-1) ** degree)
        for position in range(1, degree):
            merged = (word[position - 1] + word[position]) % N
            if merged == 0:
                continue
            face = word[: position - 1] + (merged,) + word[position + 1 :]
            target = allowed if merged in STEPS else forbidden
            add_term(target, (start, face), coefficient * (-1) ** position)
    return dict(allowed), dict(forbidden)


def alternating_cycle():
    chain = defaultdict(int)
    for start in range(N):
        for word in permutations(STEPS):
            add_term(chain, (start, word), -sign_of_permutation(word))
    return dict(chain)


def main():
    words3, rows3 = forbidden_face_rows(3)
    words4, rows4 = forbidden_face_rows(4)
    assert len(words3) == 27
    assert len(words4) == 81
    assert len(rows3) == 36
    assert len(rows4) == 162

    cycle = alternating_cycle()
    allowed_boundary, forbidden_boundary = split_boundary(cycle)
    assert len(cycle) == 78
    assert not allowed_boundary
    assert not forbidden_boundary

    selected = full_rank_minor(rows4, len(words4))
    determinant = bareiss_determinant([row for _, row in selected])
    assert determinant in (-1, 1)

    checker_path = Path(__file__).resolve()
    report = {
        "claim": "H_3^path(C_13^{1,4,6}) is nonzero",
        "parameters": {"n": N, "S": list(STEPS)},
        "cycle_terms": len(cycle),
        "forbidden_face_rows": {"degree_3": len(rows3), "degree_4": len(rows4)},
        "invariant_omega_4_unknowns": len(words4),
        "selected_minor_rows": [list(face) for face, _ in selected],
        "selected_minor_determinant": determinant,
        "checker_sha256": sha256(checker_path.read_bytes()).hexdigest(),
        "status": "pass",
    }
    output = checker_path.parents[1] / "data" / "counterexample_check_20260717.json"
    output.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    print(json.dumps(report, sort_keys=True))


if __name__ == "__main__":
    main()
