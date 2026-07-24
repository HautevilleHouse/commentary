#!/usr/bin/env python3
"""Separate exact replay for the nine inequalities packet.

This checker validates the algebraic reduction symbolically and performs a
separate finite rational-arithmetic corroboration.  The finite search is not
used as a proof of the universal statements.
"""

from __future__ import annotations

import json
import math
from fractions import Fraction

import sympy as sp


N_MAX = 300
K_MAX = 25


def trial_factors(n: int) -> list[tuple[int, int]]:
    factors: list[tuple[int, int]] = []
    candidate = 2
    while candidate * candidate <= n:
        exponent = 0
        while n % candidate == 0:
            n //= candidate
            exponent += 1
        if exponent:
            factors.append((candidate, exponent))
        candidate += 1 if candidate == 2 else 2
    if n > 1:
        factors.append((n, 1))
    return factors


def multiplicative_values(n: int) -> tuple[int, int, int]:
    phi = n
    psi = n
    sigma = 1
    for prime, exponent in trial_factors(n):
        phi = phi // prime * (prime - 1)
        psi = psi // prime * (prime + 1)
        sigma *= (prime ** (exponent + 1) - 1) // (prime - 1)
    return phi, psi, sigma


def divisors(n: int) -> list[int]:
    answer: list[int] = []
    for d in range(1, math.isqrt(n) + 1):
        if n % d == 0:
            answer.append(d)
            if d * d != n:
                answer.append(n // d)
    return answer


def is_squarefree(n: int) -> bool:
    for p in range(2, math.isqrt(n) + 1):
        if n % (p * p) == 0:
            return False
    return True


def definitional_values(n: int) -> tuple[int, int, int]:
    ds = divisors(n)
    phi = sum(1 for value in range(1, n + 1) if math.gcd(value, n) == 1)
    psi = sum(d for d in ds if is_squarefree(n // d))
    sigma = sum(ds)
    return phi, psi, sigma


def symmetric_product(values: tuple[int, int, int]) -> Fraction:
    return sum(values) * sum(Fraction(1, value) for value in values)


def cyclic_ratio(values: tuple[int, int, int]) -> Fraction:
    x, y, z = values
    return Fraction(x, y + z) + Fraction(y, x + z) + Fraction(z, x + y)


def source_values(
    n: int, k: int, a: int, b: int, c: int
) -> list[tuple[Fraction, Fraction]]:
    ak, bk, ck = a**k, b**k, c**k
    am, ap, nk = (n - 1) ** k, (n + 1) ** k, n**k

    one_lhs = symmetric_product((ak, bk, ck))
    one_rhs = Fraction(5 * (am * ap) + 2 * ap**2 + 2 * am**2, am * ap)

    two_lhs = symmetric_product(((a + b) ** k, (a + c) ** k, (b + c) ** k))
    two_rhs = Fraction(5 * nk * ap + 2 * ap**2 + 2 * nk**2, nk * ap)

    three_lhs = cyclic_ratio((ak, bk, ck))
    three_rhs = Fraction(4 * ap**2 + am * ap + am**2, 2 * (ap**2 + am * ap))

    weighted = (ak * (b + c), bk * (a + c), ck * (a + b))
    boundary_weight = n * (n + 1) ** (k - 1)
    four_lhs = symmetric_product(weighted)
    four_rhs = Fraction(
        5 * boundary_weight * am + 2 * am**2 + 2 * boundary_weight**2,
        boundary_weight * am,
    )

    power_weighted = (ak * (bk + ck), bk * (ak + ck), ck * (ak + bk))
    five_lhs = symmetric_product(power_weighted)
    five_rhs = Fraction(10 * am**2 + 7 * am * ap + ap**2, am**2 + am * ap)

    six_lhs = (
        Fraction(ak * bk, ck * (ak + bk))
        + Fraction(ak * ck, bk * (ak + ck))
        + Fraction(bk * ck, ak * (bk + ck))
    )
    six_rhs = Fraction(4 * am**2 + am * ap + ap**2, 2 * (am**2 + am * ap))

    seven_lhs = cyclic_ratio(((a + b) ** k, (a + c) ** k, (b + c) ** k))
    seven_rhs = Fraction(4 * nk**2 + ap**2 + nk * ap, 2 * (nk**2 + nk * ap))

    eight_lhs = cyclic_ratio(weighted)
    eight_rhs = Fraction(
        boundary_weight * am + am**2 + 4 * boundary_weight**2,
        2 * boundary_weight**2 + 2 * boundary_weight * am,
    )

    nine_lhs = cyclic_ratio(power_weighted)
    nine_rhs = Fraction(
        5 * am**2 + 5 * am * ap + 2 * ap**2,
        (3 * am + ap) * (am + ap),
    )

    return [
        (one_lhs, one_rhs),
        (two_lhs, two_rhs),
        (three_lhs, three_rhs),
        (four_lhs, four_rhs),
        (five_lhs, five_rhs),
        (six_lhs, six_rhs),
        (seven_lhs, seven_rhs),
        (eight_lhs, eight_rhs),
        (nine_lhs, nine_rhs),
    ]


def assert_zero(name: str, expression: sp.Expr, admitted: list[str]) -> None:
    if sp.cancel(expression) != 0:
        raise AssertionError(f"symbolic identity failed: {name}: {sp.factor(expression)}")
    admitted.append(name)


def symbolic_replay() -> list[str]:
    u, v, r, s, t = sp.symbols("u v r s t", nonzero=True)
    p, m, A, B, C, E = sp.symbols("p m A B C E")

    def P(x: sp.Expr, y: sp.Expr, z: sp.Expr) -> sp.Expr:
        return (x + y + z) * (1 / x + 1 / y + 1 / z)

    def N(x: sp.Expr, y: sp.Expr, z: sp.Expr) -> sp.Expr:
        return x / (y + z) + y / (x + z) + z / (x + y)

    left_q = 2 * u * v**2 + u * v - 2 * u**3 + 2 * u**2 - u - v - 1
    right_q = t**3 + t**2 * s + t**2 - t * s - 2 * t - 2 * s**2 + 2
    admitted: list[str] = []

    identities = {
        "P-left-step": P(1, u, v) - P(1, u, u)
        - (u + 1) * (v - u) * (v - 1) / (u * v),
        "P-left-base": P(1, u, u) - P(1, r, r)
        - 2 * (u - r) * (r * u - 1) / (r * u),
        "N-left-step": N(1, u, v) - N(1, u, u)
        - (v - u) * left_q / (2 * u * (u + 1) * (u + v) * (v + 1)),
        "N-left-base": N(1, u, u) - N(1, r, r)
        - (u - r) * (3 * r * u - r - u - 1)
        / (2 * r * u * (r + 1) * (u + 1)),
        "P-right-step": P(s, 1, t) - P(1, 1, t)
        - (t - s) * (t + 1) * (1 - s) / (t * s),
        "P-right-base": P(1, 1, t) - P(1, 1, r)
        - 2 * (t - r) * (r * t - 1) / (r * t),
        "N-right-step": N(s, 1, t) - N(1, 1, t)
        - (1 - s) * right_q / (2 * (t + 1) * (t + s) * (s + 1)),
        "N-right-base": N(1, 1, t) - N(1, 1, r)
        - (t - r) * (r * t + r + t - 3) / (2 * (r + 1) * (t + 1)),
        "left-Q-certificate": left_q
        - (
            2 * (v - u) ** 2 * u
            + 4 * (v - u) * u**2
            + (v - u) * (u - 1)
            + (3 * u + 1) * (u - 1)
        ),
        "right-Q-certificate": right_q
        - (
            (t - 1) ** 3
            + 4 * (t - 1) ** 2
            + 3 * (t - 1)
            + 2 * (1 - s)
            + s * (t - 1) ** 2
            + s * (t - 1)
            + 2 * (1 - s) * s
        ),
        "gap-prime-base": p * ((p + 1) - (p - 1)) - (p - 1) - (p + 1),
        "gap-fresh-prime-step": (
            p * m * ((p + 1) * B - (p - 1) * A) - (p - 1) * A - (p + 1) * C
        )
        - p**2 * (m * (B - A) - A - C)
        - (p * m * (A + B) + (p**2 - p + 1) * A + (p**2 - p - 1) * C),
        "gap-repeated-prime-step": (
            p**2 * m * (B - A) - p * A - (p * C + E)
        )
        - p**2 * (m * (B - A) - A - C)
        - (p * (p - 1) * (A + C) - E),
    }
    for name, expression in identities.items():
        assert_zero(name, expression, admitted)

    rho = B / A
    p_boundary = 5 + 2 * rho + 2 / rho
    n_left = 1 / (2 * rho) + 2 * rho / (1 + rho)
    n_right = rho / 2 + 2 / (1 + rho)
    boundary_identities = {
        "source-P-boundary": (5 * A * B + 2 * A**2 + 2 * B**2) / (A * B)
        - p_boundary,
        "source-N-left-boundary": (4 * B**2 + A * B + A**2) / (2 * (B**2 + A * B))
        - n_left,
        "source-N-right-boundary": (4 * A**2 + A * B + B**2) / (2 * (A**2 + A * B))
        - n_right,
    }
    for name, expression in boundary_identities.items():
        assert_zero(name, expression, admitted)

    rho5 = (A + B) / (2 * A)
    assert_zero(
        "source-P-power-weighted-boundary",
        (10 * A**2 + 7 * A * B + B**2) / (A**2 + A * B)
        - (5 + 2 * rho5 + 2 / rho5),
        admitted,
    )
    assert_zero(
        "source-N-power-weighted-boundary",
        (5 * A**2 + 5 * A * B + 2 * B**2) / ((3 * A + B) * (A + B))
        - (1 / (2 * rho5) + 2 * rho5 / (1 + rho5)),
        admitted,
    )
    return admitted


def finite_replay() -> dict[str, object]:
    equality_counts = {index: 0 for index in range(1, 10)}
    failures: list[dict[str, int]] = []
    implementation_mismatches: list[int] = []

    for n in range(2, N_MAX + 1):
        first = multiplicative_values(n)
        second = definitional_values(n)
        if first != second:
            implementation_mismatches.append(n)
            continue
        for k in range(1, K_MAX + 1):
            for index, (lhs, rhs) in enumerate(source_values(n, k, *first), start=1):
                if lhs < rhs:
                    failures.append({"conjecture": index, "n": n, "k": k})
                if lhs == rhs:
                    equality_counts[index] += 1

    prime_count = sum(
        1
        for n in range(2, N_MAX + 1)
        if all(n % d for d in range(2, math.isqrt(n) + 1))
    )
    expected_equalities = prime_count * K_MAX
    if implementation_mismatches or failures:
        raise AssertionError(
            f"finite replay failed: mismatches={implementation_mismatches}, failures={failures[:3]}"
        )
    if any(count != expected_equalities for count in equality_counts.values()):
        raise AssertionError(
            f"unexpected equality counts: {equality_counts}; expected {expected_equalities}"
        )

    return {
        "n_range": [2, N_MAX],
        "k_range": [1, K_MAX],
        "pairs_per_conjecture": (N_MAX - 1) * K_MAX,
        "implementation_mismatches": 0,
        "inequality_failures": 0,
        "equalities_per_conjecture": equality_counts,
        "equality_basis": "prime n only within the declared finite range",
        "universal_claim_basis": "algebraic proof, not finite search",
    }


def main() -> int:
    symbolic = symbolic_replay()
    finite = finite_replay()
    print(
        json.dumps(
            {
                "status": "admitted",
                "source": "arXiv:2606.12484v1, Conjectures 1-9",
                "openconjecture_ids": list(range(3856, 3865)),
                "arithmetic": "exact integers and fractions",
                "symbolic_identities": symbolic,
                "symbolic_identity_count": len(symbolic),
                "finite_replay": finite,
            },
            indent=2,
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
