#!/usr/bin/env python3
"""Deterministic replay checks for the Q_01 coefficient classification."""

from __future__ import annotations

import json
from functools import lru_cache


def primes_up_to(limit: int) -> list[int]:
    sieve = [True] * (limit + 1)
    sieve[:2] = [False, False]
    for p in range(2, int(limit**0.5) + 1):
        if sieve[p]:
            sieve[p * p : limit + 1 : p] = [False] * (
                (limit - p * p) // p + 1
            )
    return [n for n, is_prime in enumerate(sieve) if is_prime]


def triangular_coefficient(index: int, q: int) -> int:
    if index < 0 or index > 2 * q - 2:
        return 0
    if index < q:
        return index + 1
    return 2 * q - 1 - index


def low_coefficient(index: int, p: int, q: int) -> int:
    assert 0 <= index < p * q
    step = p * p
    total = 0
    for j in range(index // step + 1):
        total += triangular_coefficient(index - j * step, q)
        total -= triangular_coefficient(index - p - j * step, q)
    return total


def p_equals_two_closed_form(index: int, q: int) -> int:
    assert q % 2 == 1
    m = (q - 1) // 2
    if index < q:
        if index % 2 == 0:
            return index // 2 + 1
        s = (index - 1) // 2
        return 2 * (s // 2 + 1)
    r = index - q
    if r % 2 == 0:
        t = r // 2
        if t % 2 == 0:
            return 2 * (m // 2) - t
        return 2 * ((m + 1) // 2) - t - 1
    t = (r - 1) // 2
    if t % 2 == 0:
        return m - 2 - t
    return m - t


def period_sums(p: int, q: int) -> list[int]:
    period = p * p
    sums = [0] * period
    for index in range(2 * q - 1):
        sums[index % period] += triangular_coefficient(index, q)
    return sums


def odd_prime_witness(p: int, q: int) -> tuple[str, int, int]:
    assert p % 2 == 1 and p != q
    if p >= 2 * q - 1:
        index = p
        return "low_support", index, low_coefficient(index, p, q)
    midpoint_index = q + (p - 1) // 2
    if midpoint_index < p * p:
        return "midpoint_crossing", midpoint_index, low_coefficient(
            midpoint_index, p, q
        )
    period = p * p
    sums = period_sums(p, q)
    differences = [sums[r] - sums[(r - p) % period] for r in range(period)]
    assert sum(differences) == 0
    negative_residues = [r for r, value in enumerate(differences) if value < 0]
    assert negative_residues
    start = 2 * q - 2 + p
    end = p * q - 1
    assert end - start + 1 >= period
    residue = negative_residues[0]
    index = start + (residue - start) % period
    assert index <= end
    coefficient = low_coefficient(index, p, q)
    assert coefficient == differences[residue]
    return "periodic_descent", index, coefficient


def trim(poly: list[int]) -> list[int]:
    while len(poly) > 1 and poly[-1] == 0:
        poly.pop()
    return poly


def poly_multiply(left: list[int], right: list[int]) -> list[int]:
    result = [0] * (len(left) + len(right) - 1)
    for i, a in enumerate(left):
        if a == 0:
            continue
        for j, b in enumerate(right):
            if b:
                result[i + j] += a * b
    return trim(result)


def divide_by_monic(dividend: list[int], divisor: list[int]) -> list[int]:
    work = dividend[:]
    quotient = [0] * max(1, len(work) - len(divisor) + 1)
    while len(work) >= len(divisor):
        shift = len(work) - len(divisor)
        coefficient = work[-1]
        quotient[shift] = coefficient
        if coefficient:
            for i, value in enumerate(divisor):
                work[shift + i] -= coefficient * value
        trim(work)
    assert work == [0], f"nonzero polynomial remainder: {work}"
    return trim(quotient)


def divisors(n: int) -> list[int]:
    small: list[int] = []
    large: list[int] = []
    d = 1
    while d * d <= n:
        if n % d == 0:
            small.append(d)
            if d * d != n:
                large.append(n // d)
        d += 1
    return small + list(reversed(large))


@lru_cache(maxsize=None)
def cyclotomic(n: int) -> tuple[int, ...]:
    polynomial = [-1] + [0] * (n - 1) + [1]
    for divisor in divisors(n):
        if divisor == n:
            break
        polynomial = divide_by_monic(polynomial, list(cyclotomic(divisor)))
    return tuple(polynomial)


def direct_q01(p: int, q: int) -> list[int]:
    phi_q = list(cyclotomic(q))
    phi_p2q = list(cyclotomic(p * p * q))
    return poly_multiply(poly_multiply(phi_q, phi_q), phi_p2q)


def main() -> None:
    p2_q_values = 0
    p2_coefficients = 0
    for q in range(3, 1002, 2):
        p2_q_values += 1
        center = 2 * q - 2
        coefficients = [low_coefficient(n, 2, q) for n in range(center + 1)]
        predicted = [p_equals_two_closed_form(n, q) for n in range(center + 1)]
        assert coefficients == predicted
        p2_coefficients += len(coefficients)
        if q % 4 == 1:
            assert min(coefficients) >= 0
        else:
            assert coefficients[-1] == -1
            assert min(coefficients[:-1]) >= 0

    odd_primes = [p for p in primes_up_to(97) if p != 2]
    q_primes = primes_up_to(499)
    odd_pairs = 0
    case_counts = {
        "low_support": 0,
        "midpoint_crossing": 0,
        "periodic_descent": 0,
    }
    minimum_witness = 0
    for p in odd_primes:
        for q in q_primes:
            if p == q:
                continue
            case, index, coefficient = odd_prime_witness(p, q)
            assert 0 <= index < p * q
            assert coefficient < 0
            odd_pairs += 1
            case_counts[case] += 1
            minimum_witness = min(minimum_witness, coefficient)

    direct_primes = primes_up_to(19)
    direct_pairs = 0
    direct_coefficients = 0
    direct_low_coefficients = 0
    for p in direct_primes:
        for q in direct_primes:
            if p == q:
                continue
            polynomial = direct_q01(p, q)
            direct_pairs += 1
            direct_coefficients += len(polynomial)
            expected_nonnegative = p == 2 and q % 4 == 1
            assert (min(polynomial) >= 0) == expected_nonnegative
            for index in range(min(p * q, len(polynomial))):
                assert polynomial[index] == low_coefficient(index, p, q)
                direct_low_coefficients += 1

    result = {
        "schema_version": "2026-07-18.dice_q01_nonnegativity_replay.v1",
        "theorem": (
            "For distinct primes p and q, x*Phi_q(x)^2*Phi_{p^2*q}(x) "
            "has nonnegative coefficients exactly when p=2 and q=1 mod 4."
        ),
        "checks": {
            "p_equals_two_odd_q_values_checked": p2_q_values,
            "p_equals_two_first_half_coefficients_checked": p2_coefficients,
            "odd_prime_pairs_checked": odd_pairs,
            "odd_case_counts": case_counts,
            "direct_cyclotomic_prime_pairs_checked": direct_pairs,
            "direct_cyclotomic_coefficients_checked": direct_coefficients,
            "direct_low_degree_coefficients_cross_checked": direct_low_coefficients,
            "minimum_constructed_witness_coefficient": minimum_witness,
        },
        "bounded_scope": {
            "closed_form_q": "every odd integer 3 through 1001",
            "odd_witness_grid": "odd primes p <= 97 and primes q <= 499",
            "independent_cyclotomic_grid": "all ordered distinct prime pairs p,q <= 19",
        },
        "all_pass": True,
    }
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
