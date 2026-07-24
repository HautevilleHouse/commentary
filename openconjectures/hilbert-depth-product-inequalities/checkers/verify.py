#!/usr/bin/env python3
"""Supporting checks for arXiv:2602.09607v1, Conjecture 4.1."""

from __future__ import annotations

import json
from decimal import Decimal, ROUND_CEILING, getcontext
from fractions import Fraction


SOURCE_ARCHIVE_SHA256 = (
    "2b3a73c98fe1fe0b9ee73be69f5308a6eaac279f5df9cd1cd769819aaef74ce8"
)


def multiply(values: list[Fraction]) -> Fraction:
    result = Fraction(1)
    for value in values:
        result *= value
    return result


def source_factors(case: str, s: int, k: int) -> list[Fraction]:
    if case == "a":
        return [Fraction(k - j + 2 * s + 1, k - j) for j in range(1, 2 * s + 1)]
    if case == "b":
        return [Fraction(k - j + 2 * s + 2, k - j) for j in range(1, 2 * s + 2)]
    if case == "c":
        return [Fraction(k - j + 2 * s, k - j) for j in range(0, 2 * s)]
    if case == "d":
        return [Fraction(k - j + 2 * s + 2, k - j) for j in range(2, 2 * s + 2)]
    raise ValueError(case)


def paired_factors(case: str, s: int, k: int) -> list[Fraction]:
    if case in {"a", "b"}:
        r = 2 * s if case == "a" else 2 * s + 1
        return [Fraction(k + i, k - i) for i in range(1, r + 1)]
    if case == "c":
        r, x = 2 * s, Fraction(2 * k + 1, 2)
        return [
            (x + Fraction(2 * i - 1, 2)) / (x - Fraction(2 * i - 1, 2))
            for i in range(1, r + 1)
        ]
    if case == "d":
        r, x = 2 * s, Fraction(2 * k - 1, 2)
        return [
            (x + Fraction(2 * i + 1, 2)) / (x - Fraction(2 * i + 1, 2))
            for i in range(1, r + 1)
        ]
    raise ValueError(case)


def real_threshold(case: str, s: int, log_two: Decimal) -> Decimal:
    if case == "a":
        radius = Decimal(2 * s) + Decimal("0.5")
        return radius * radius / log_two
    if case == "b":
        radius = Decimal(2 * s) + Decimal("1.5")
        return radius * radius / log_two
    if case == "c":
        return Decimal(4 * s * s) / log_two
    if case == "d":
        radius = Decimal(2 * s + 1)
        return radius * radius / log_two
    raise ValueError(case)


def integer_threshold(case: str, s: int, log_two: Decimal) -> int:
    return int(real_threshold(case, s, log_two).to_integral_value(rounding=ROUND_CEILING))


def source_log_product(case: str, s: int, k: int | Decimal) -> Decimal:
    if case == "a":
        indices, addition = range(1, 2 * s + 1), 2 * s + 1
    elif case == "b":
        indices, addition = range(1, 2 * s + 2), 2 * s + 2
    elif case == "c":
        indices, addition = range(0, 2 * s), 2 * s
    elif case == "d":
        indices, addition = range(2, 2 * s + 2), 2 * s + 2
    else:
        raise ValueError(case)
    return sum(
        (Decimal(1) + Decimal(addition) / (Decimal(k) - Decimal(j))).ln()
        for j in indices
    )


def exact_certificate() -> dict[str, str]:
    b = Fraction(7, 10)
    exp_partial = Fraction(1) + b + b**2 / 2 + b**3 / 6
    ab_left = 2 * b**2
    ab_right = 3 * (1 - b**2 / Fraction(25, 4))
    c_margin = (3 - b) * 4 - Fraction(7, 2) * b**2
    d_scale_margin = 1 - b / 18 - Fraction(24, 25)
    d_q_upper = b**2 * Fraction(25, 24) ** 2 / 9
    d_power_upper = Fraction(25, 24) ** 3
    d_tail_upper = Fraction(49, 470)
    d_gap_lower = Fraction(13, 20)

    assert exp_partial > 2
    assert ab_left < ab_right
    assert c_margin > 0
    assert d_scale_margin > 0
    assert d_q_upper < Fraction(3, 50)
    assert d_power_upper < Fraction(6, 5)
    assert d_tail_upper < d_gap_lower

    return {
        "ab_left": str(ab_left),
        "ab_right": str(ab_right),
        "c_margin": str(c_margin),
        "d_gap_ratio_lower": str(d_gap_lower),
        "d_power_upper": str(d_power_upper),
        "d_q_upper": str(d_q_upper),
        "d_scale_margin": str(d_scale_margin),
        "d_tail_ratio_upper": str(d_tail_upper),
        "exp_partial": str(exp_partial),
    }


def main() -> int:
    getcontext().prec = 80
    log_two = Decimal(2).ln()

    identities = 0
    for case in "abcd":
        for s in range(1, 11):
            k = integer_threshold(case, s, log_two)
            assert multiply(source_factors(case, s, k)) == multiply(
                paired_factors(case, s, k)
            )
            identities += 1

    certificate = exact_certificate()
    samples = list(range(1, 129)) + [256, 512, 1024, 2048, 4096, 5000]
    integer_count = 0
    endpoint_count = 0
    minimum_integer: tuple[Decimal, str, int] | None = None
    minimum_endpoint: tuple[Decimal, str, int] | None = None

    for case in "abcd":
        for s in samples:
            integer_margin = log_two - source_log_product(
                case, s, integer_threshold(case, s, log_two)
            )
            endpoint_margin = log_two - source_log_product(
                case, s, real_threshold(case, s, log_two)
            )
            assert integer_margin > 0
            assert endpoint_margin > 0
            item_integer = (integer_margin, case, s)
            item_endpoint = (endpoint_margin, case, s)
            if minimum_integer is None or item_integer[0] < minimum_integer[0]:
                minimum_integer = item_integer
            if minimum_endpoint is None or item_endpoint[0] < minimum_endpoint[0]:
                minimum_endpoint = item_endpoint
            integer_count += 1
            endpoint_count += 1

    assert minimum_integer is not None and minimum_endpoint is not None
    print(
        json.dumps(
            {
                "all_pass": True,
                "claim_boundary": (
                    "Exact checks cover the product rewrites and rational tail "
                    "comparisons. The all-parameter theorem is in PROOF.md."
                ),
                "exact_product_identities_checked": identities,
                "minimum_numerical_margin": format(minimum_integer[0], "E"),
                "minimum_numerical_margin_case": minimum_integer[1],
                "minimum_numerical_margin_s": minimum_integer[2],
                "minimum_real_endpoint_margin": format(minimum_endpoint[0], "E"),
                "minimum_real_endpoint_margin_case": minimum_endpoint[1],
                "minimum_real_endpoint_margin_s": minimum_endpoint[2],
                "numerical_source_instances_checked": integer_count,
                "rational_certificate": certificate,
                "real_lower_endpoints_checked": endpoint_count,
                "schema_version": "2026-07-18.hilbert_depth_product_inequalities_check.v1",
                "source": "arXiv:2602.09607v1",
                "source_archive_sha256": SOURCE_ARCHIVE_SHA256,
            },
            separators=(",", ":"),
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
