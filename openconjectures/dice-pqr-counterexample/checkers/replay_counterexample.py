#!/usr/bin/env python3
"""Replay the dice pqr counterexample certificate.

The script is path-neutral and uses only Python's standard library. It rebuilds
the cyclotomic products for (a,b,c,d)=(1,1,1,1) and (p,q,r)=(3,5,11), checks
that both dice polynomials have no negative coefficients, and checks that their
product equals the standard two-dice frequency polynomial.
"""

from __future__ import annotations

import hashlib
import json
from functools import lru_cache
from pathlib import Path


CASE = (1, 1, 1, 1)
TRIPLE = (3, 5, 11)


def trim(poly: list[int]) -> list[int]:
    while len(poly) > 1 and poly[-1] == 0:
        poly.pop()
    return poly


def poly_mul(left: list[int], right: list[int]) -> list[int]:
    out = [0] * (len(left) + len(right) - 1)
    for i, a in enumerate(left):
        if a == 0:
            continue
        for j, b in enumerate(right):
            if b:
                out[i + j] += a * b
    return trim(out)


def poly_pow(poly: list[int], exp: int) -> list[int]:
    out = [1]
    base = poly[:]
    power = exp
    while power:
        if power & 1:
            out = poly_mul(out, base)
        power >>= 1
        if power:
            base = poly_mul(base, base)
    return out


def poly_div_exact(numerator: list[int], denominator: list[int]) -> list[int]:
    num = trim(numerator[:])
    den = trim(denominator[:])
    quotient = [0] * (len(num) - len(den) + 1)
    den_lead = den[-1]
    while len(num) >= len(den) and num != [0]:
        degree_delta = len(num) - len(den)
        lead = num[-1]
        if lead % den_lead != 0:
            raise ValueError("non-integral polynomial division")
        coeff = lead // den_lead
        quotient[degree_delta] = coeff
        for i, den_coeff in enumerate(den):
            num[degree_delta + i] -= coeff * den_coeff
        trim(num)
    if any(num):
        raise ValueError("non-exact polynomial division")
    return trim(quotient)


def divisors(n: int) -> list[int]:
    out: list[int] = []
    for d in range(1, int(n**0.5) + 1):
        if n % d == 0:
            out.append(d)
            if d * d != n:
                out.append(n // d)
    return sorted(out)


@lru_cache(maxsize=None)
def cyclotomic(n: int) -> tuple[int, ...]:
    poly = [-1] + [0] * (n - 1) + [1]
    for d in divisors(n):
        if d != n:
            poly = poly_div_exact(poly, list(cyclotomic(d)))
    return tuple(poly)


def mul_many(polys: list[list[int]]) -> list[int]:
    out = [1]
    for poly in polys:
        out = poly_mul(out, poly)
    return out


def phi_power(n: int, exp: int) -> list[int]:
    return poly_pow(list(cyclotomic(n)), exp)


def coeffs_sha256(poly: list[int]) -> str:
    payload = json.dumps(poly, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(payload).hexdigest()


def standard_two_dice_frequency(m: int) -> list[int]:
    die = [0] + [1] * m
    return poly_mul(die, die)


def build_a() -> list[int]:
    a, b, c, d = CASE
    p, q, r = TRIPLE
    return mul_many(
        [
            [0, 1],
            phi_power(p, 2),
            phi_power(q, 2),
            phi_power(p * q, a),
            phi_power(p * r, b),
            phi_power(q * r, c),
            phi_power(p * q * r, d),
        ]
    )


def build_b_pair() -> list[int]:
    a, b, c, d = CASE
    p, q, r = TRIPLE
    alpha, beta, gamma, delta = 2 - a, 2 - b, 2 - c, 2 - d
    return mul_many(
        [
            [0, 1],
            phi_power(r, 2),
            phi_power(p * q, alpha),
            phi_power(p * r, beta),
            phi_power(q * r, gamma),
            phi_power(p * q * r, delta),
        ]
    )


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    cert_path = root / "data" / "dice_pqr_counterexample_1111_p3_q5_r11.json"
    cert = json.loads(cert_path.read_text(encoding="utf-8"))

    a_poly = build_a()
    b_poly = build_b_pair()
    product = poly_mul(a_poly, b_poly)
    target = standard_two_dice_frequency(3 * 5 * 11)

    result = {
        "A_min_coefficient": min(a_poly),
        "B_pair_min_coefficient": min(b_poly),
        "A_side_count_A_at_1": sum(a_poly),
        "B_side_count_B_at_1": sum(b_poly),
        "A_coefficients_sha256": coeffs_sha256(a_poly),
        "B_pair_coefficients_sha256": coeffs_sha256(b_poly),
        "product_equals_target": product == target,
        "target_coefficients_sha256": coeffs_sha256(target),
    }

    expected = {
        "A_coefficients_sha256": cert["A"]["coefficients_sha256"],
        "B_pair_coefficients_sha256": cert["B_pair"]["coefficients_sha256"],
        "target_coefficients_sha256": cert["product_check"]["target_coefficients_sha256"],
    }
    hash_check = {key: result[key] == value for key, value in expected.items()}
    endpoint_check = (
        result["A_min_coefficient"] == 0
        and result["B_pair_min_coefficient"] == 0
        and result["A_side_count_A_at_1"] == 225
        and result["B_side_count_B_at_1"] == 121
        and result["product_equals_target"]
        and all(hash_check.values())
    )

    print(json.dumps({"endpoint_check": endpoint_check, "result": result, "hash_check": hash_check}, indent=2, sort_keys=True))
    if not endpoint_check:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
