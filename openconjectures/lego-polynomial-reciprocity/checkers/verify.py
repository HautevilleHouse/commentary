#!/usr/bin/env python3
"""Separate finite checks for the LEGO polynomial reciprocity proof.

The checker performs three distinct jobs:

1. verify the paper's listed binomial-basis rows through n=8;
2. reconstruct p_n(w) directly from labelled geometric placements for n<=4;
3. check the Lipschitz-polytope reciprocity identity for every connected
   simple graph on at most four vertices.

The computations validate transcription and the finite model.  The all-n
theorem is supplied by the accompanying mathematical proof.
"""

from __future__ import annotations

import itertools
import json
from fractions import Fraction
from math import comb, factorial


SOURCE_ROWS = {
    1: (1,),
    2: (1, 2),
    3: (1, 10, 10),
    4: (1, 43, 123, 82),
    5: (1, 185, 1135, 1900, 950),
    6: (1, 813, 9563, 30142, 35650, 14260),
    7: (1, 3655, 78046, 412510, 865575, 791184, 263728),
    8: (
        1,
        16730,
        630078,
        5252794,
        17398280,
        27257646,
        20298334,
        5799524,
    ),
}


def add(left: list[Fraction], right: list[Fraction]) -> list[Fraction]:
    result = [Fraction(0)] * max(len(left), len(right))
    for index, value in enumerate(left):
        result[index] += value
    for index, value in enumerate(right):
        result[index] += value
    return result


def scale(poly: list[Fraction], factor: Fraction) -> list[Fraction]:
    return [factor * value for value in poly]


def multiply(left: list[Fraction], right: list[Fraction]) -> list[Fraction]:
    result = [Fraction(0)] * (len(left) + len(right) - 1)
    for left_index, left_value in enumerate(left):
        for right_index, right_value in enumerate(right):
            result[left_index + right_index] += left_value * right_value
    return result


def shifted_binomial_polynomial(k: int) -> list[Fraction]:
    """Return coefficients of binomial(w - 1, k), increasing in degree."""

    result = [Fraction(1)]
    for root in range(1, k + 1):
        result = multiply(result, [Fraction(-root), Fraction(1)])
    return scale(result, Fraction(1, factorial(k)))


def polynomial_from_types(type_counts: tuple[int, ...]) -> list[Fraction]:
    result = [Fraction(0)]
    for k, count in enumerate(type_counts):
        result = add(
            result,
            scale(shifted_binomial_polynomial(k), Fraction(count)),
        )
    return result


def substitute_one_minus(poly: list[Fraction]) -> list[Fraction]:
    result = [Fraction(0)] * len(poly)
    for degree, coefficient in enumerate(poly):
        for output_degree in range(degree + 1):
            result[output_degree] += (
                coefficient
                * comb(degree, output_degree)
                * (-1) ** output_degree
            )
    return result


def substitute_negative_one_minus(poly: list[Fraction]) -> list[Fraction]:
    """Return coefficients of p(-t-1), increasing in degree."""

    result = [Fraction(0)] * len(poly)
    for degree, coefficient in enumerate(poly):
        for output_degree in range(degree + 1):
            result[output_degree] += (
                coefficient
                * (-1) ** degree
                * comb(degree, output_degree)
            )
    return result


def h_numerator(type_counts: tuple[int, ...]) -> list[Fraction]:
    d = len(type_counts) - 1
    result = [Fraction(0)] * (d + 1)
    for k, count in enumerate(type_counts):
        one_minus_power = [
            Fraction(comb(d - k, degree) * (-1) ** degree)
            for degree in range(d - k + 1)
        ]
        term = [Fraction(0)] * k + scale(one_minus_power, Fraction(count))
        result = add(result, term)
    return result


def evaluate(poly: list[Fraction], value: int) -> Fraction:
    result = Fraction(0)
    for coefficient in reversed(poly):
        result = result * value + coefficient
    return result


def interpolate(values: list[int]) -> list[Fraction]:
    """Interpolate p(0),...,p(d) in the monomial basis."""

    result = [Fraction(0)]
    for point, value in enumerate(values):
        basis = [Fraction(1)]
        denominator = Fraction(1)
        for other in range(len(values)):
            if other == point:
                continue
            basis = multiply(basis, [Fraction(-other), Fraction(1)])
            denominator *= point - other
        result = add(result, scale(basis, Fraction(value) / denominator))
    return result


def all_pairs(n: int) -> tuple[tuple[int, int], ...]:
    return tuple(itertools.combinations(range(n), 2))


def connected(n: int, edges: tuple[tuple[int, int], ...]) -> bool:
    if n == 1:
        return True
    adjacency = [[] for _ in range(n)]
    for left, right in edges:
        adjacency[left].append(right)
        adjacency[right].append(left)
    seen = {0}
    stack = [0]
    while stack:
        vertex = stack.pop()
        for neighbor in adjacency[vertex]:
            if neighbor not in seen:
                seen.add(neighbor)
                stack.append(neighbor)
    return len(seen) == n


def connected_graphs(n: int):
    pairs = all_pairs(n)
    for mask in range(1 << len(pairs)):
        edges = tuple(pair for index, pair in enumerate(pairs) if mask >> index & 1)
        if connected(n, edges):
            yield edges


def lipschitz_count(n: int, edges: tuple[tuple[int, int], ...], t: int) -> int:
    """Count lattice points of t P_G with x_0 fixed to zero."""

    d = n - 1
    bound = d * t
    count = 0
    for tail in itertools.product(range(-bound, bound + 1), repeat=d):
        x = (0,) + tail
        if all(abs(x[left] - x[right]) <= t for left, right in edges):
            count += 1
    return count


def direct_labelled_lego_count(n: int, w: int) -> int:
    """Reconstruct the paper's oriented translation classes via labels."""

    t = w - 1
    d = n - 1
    bound = d * t
    total = 0
    pairs = all_pairs(n)

    for y in itertools.product(range(n), repeat=n):
        if min(y) != 0:
            continue
        adjacent_pairs = tuple(pair for pair in pairs if abs(y[pair[0]] - y[pair[1]]) == 1)
        if not connected(n, adjacent_pairs):
            continue
        same_row_pairs = tuple(pair for pair in pairs if y[pair[0]] == y[pair[1]])

        for tail in itertools.product(range(-bound, bound + 1), repeat=d):
            x = (0,) + tail
            if any(abs(x[left] - x[right]) <= t for left, right in same_row_pairs):
                continue
            contact_edges = tuple(
                pair
                for pair in adjacent_pairs
                if abs(x[pair[0]] - x[pair[1]]) <= t
            )
            if connected(n, contact_edges):
                total += 1
    return total


def encode(poly: list[Fraction]) -> list[int | str]:
    return [
        value.numerator
        if value.denominator == 1
        else f"{value.numerator}/{value.denominator}"
        for value in poly
    ]


def main() -> int:
    source_records = []
    for n, type_counts in SOURCE_ROWS.items():
        polynomial = polynomial_from_types(type_counts)
        reflected = substitute_one_minus(polynomial)
        expected = scale(polynomial, Fraction((-1) ** (n - 1)))
        numerator = h_numerator(type_counts)
        if reflected != expected or numerator != numerator[::-1]:
            raise AssertionError(f"source row n={n} failed reciprocity")
        source_records.append(
            {
                "n": n,
                "type_counts": list(type_counts),
                "polynomial_coefficients_increasing_degree": encode(polynomial),
                "h_numerator": encode(numerator),
            }
        )

    graph_records = []
    for n in range(1, 5):
        d = n - 1
        graph_count = 0
        for edges in connected_graphs(n):
            values = [lipschitz_count(n, edges, t) for t in range(d + 1)]
            polynomial = interpolate(values)
            reflected = substitute_negative_one_minus(polynomial)
            if reflected != scale(polynomial, Fraction((-1) ** d)):
                raise AssertionError(f"graph reciprocity failed n={n}, edges={edges}")
            graph_count += 1
        graph_records.append({"n": n, "connected_graphs_checked": graph_count})

    reconstruction_records = []
    for n in range(1, 5):
        polynomial = polynomial_from_types(SOURCE_ROWS[n])
        for w in range(1, n + 1):
            labelled = direct_labelled_lego_count(n, w)
            if labelled % factorial(n):
                raise AssertionError(f"nonintegral label quotient n={n}, w={w}")
            reconstructed = labelled // factorial(n)
            expected = evaluate(polynomial, w)
            if expected.denominator != 1 or reconstructed != expected.numerator:
                raise AssertionError(
                    f"direct reconstruction mismatch n={n}, w={w}: "
                    f"{reconstructed} != {expected}"
                )
            reconstruction_records.append(
                {
                    "n": n,
                    "w": w,
                    "labelled_count": labelled,
                    "translation_classes": reconstructed,
                }
            )

    print(
        json.dumps(
            {
                "schema_version": "2026-07-18.lego_reciprocity_proof_check.v2",
                "source": "arXiv:2605.07380v1",
                "all_pass": True,
                "source_rows_checked": len(source_records),
                "source_records": source_records,
                "graph_reciprocity": graph_records,
                "direct_reconstruction": reconstruction_records,
                "claim_boundary": (
                    "Finite checks validate source transcription, all connected "
                    "graphs on at most four vertices, and direct LEGO counts through "
                    "n=4. The arbitrary-n theorem is proved in the accompanying public proof."
                ),
            },
            separators=(",", ":"),
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
