#!/usr/bin/env python3
"""Replay the arithmetic evidence for the OpenConjecture 2765 proof."""

from __future__ import annotations

import hashlib
import json
import math
import platform
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "resolution_check_20260717.json"
SCAN_BOUND = 1000
EXPECTED_VALUES = {3: {1, 5}, 4: {2, 3}, 6: {4, 8}}
WITNESSES = {
    3: ((4, 4, 1), (4, 6, 5)),
    4: ((2, 2, 2), (2, 4, 3)),
    6: ((1, 1, 4), (1, 3, 8)),
}


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def equation_value(a: int, b: int) -> int | None:
    numerator = a * (a + 2) + b * (b + 2)
    denominator = a * b
    quotient, remainder = divmod(numerator, denominator)
    return quotient if remainder == 0 else None


def normalized_value(a: int, b: int) -> int:
    divisor = math.gcd(a, b)
    numerator = 2 * (a + b)
    denominator = divisor * divisor
    quotient, remainder = divmod(numerator, denominator)
    if remainder:
        raise ValueError(f"normalized value is nonintegral for {(a, b)}")
    return quotient


def check_witnesses() -> list[dict]:
    rows = []
    for k, witnesses in WITNESSES.items():
        for a, b, expected in witnesses:
            actual_k = equation_value(a, b)
            actual_value = normalized_value(a, b)
            rows.append(
                {
                    "a": a,
                    "b": b,
                    "expected_k": k,
                    "actual_k": actual_k,
                    "expected_value": expected,
                    "actual_value": actual_value,
                    "passed": actual_k == k and actual_value == expected,
                }
            )
    return rows


def check_odd_residues() -> dict:
    residues = sorted(
        {
            (6 * x * y - x * x - y * y) % 16
            for x in range(1, 16, 2)
            for y in range(1, 16, 2)
        }
    )
    divisors = [value for value in range(1, 33) if 32 % value == 0]
    survivors = [value for value in divisors if value % 16 in residues]
    return {
        "odd_x_y_Q_residues_mod_16": residues,
        "positive_divisors_of_32": divisors,
        "surviving_divisors": survivors,
        "passed": residues == [4, 8] and survivors == [4, 8],
    }


def check_coprime_normalization() -> dict:
    cases = []
    for x in range(1, 64, 2):
        for y in range(1, 64, 2):
            if math.gcd(x, y) != 1:
                continue
            q = 6 * x * y - x * x - y * y
            if q <= 0 or 2 * (x + y) % q:
                continue
            d = 2 * (x + y) // q
            a, b = d * x, d * y
            cases.append(
                {
                    "x": x,
                    "y": y,
                    "d": d,
                    "a": a,
                    "b": b,
                    "Q": q,
                    "equation_k": equation_value(a, b),
                    "normalized_value": normalized_value(a, b),
                }
            )
    return {
        "primitive_case_count": len(cases),
        "Q_values": sorted({row["Q"] for row in cases}),
        "all_reconstruct_k6_solutions": all(
            row["equation_k"] == 6 and row["normalized_value"] == row["Q"]
            for row in cases
        ),
        "cases": cases,
    }


def bounded_scan() -> dict:
    counts = {3: 0, 4: 0, 6: 0}
    values = {3: set(), 4: set(), 6: set()}
    unexpected = []
    for a in range(1, SCAN_BOUND + 1):
        for b in range(1, SCAN_BOUND + 1):
            k = equation_value(a, b)
            if k is None:
                continue
            value = normalized_value(a, b)
            if k not in EXPECTED_VALUES or value not in EXPECTED_VALUES[k]:
                unexpected.append({"a": a, "b": b, "k": k, "value": value})
                continue
            counts[k] += 1
            values[k].add(value)
    return {
        "coordinate_bound": SCAN_BOUND,
        "ordered_solution_counts": {str(k): counts[k] for k in counts},
        "observed_values": {str(k): sorted(values[k]) for k in values},
        "unexpected": unexpected,
        "passed": not unexpected
        and all(values[k] == EXPECTED_VALUES[k] for k in EXPECTED_VALUES),
    }


def build_payload() -> dict:
    witnesses = check_witnesses()
    residues = check_odd_residues()
    primitive = check_coprime_normalization()
    scan = bounded_scan()
    checks = {
        "all_attainment_witnesses_pass": all(row["passed"] for row in witnesses),
        "odd_residue_and_divisor_reduction_pass": residues["passed"],
        "primitive_reconstruction_pass": primitive["all_reconstruct_k6_solutions"]
        and primitive["Q_values"] == [4, 8],
        "bounded_scan_pass": scan["passed"],
    }
    payload = {
        "source": {
            "openconjecture_id": 2765,
            "dataset_arxiv_id": "2605.19083v1",
            "current_arxiv_id": "2605.19083v2",
            "source_file": "FibNumbVietaJumpRatDiophEq_MNS_v10.tex",
            "source_lines": "942-958",
            "source_claim_body_sha256": "70df689b615a35468266c66a5118d72725bed0b997891f417d423517c14de837",
        },
        "symbolic_result": {
            "source_orbit_reduction": "k in {3,4,6}, with every solution connected to its diagonal solution",
            "k3_k4_reduction": "a=2A and b=2B reduce to source Theorem 3.5",
            "k6_normalization": "Q=6xy-x^2-y^2, dQ=2(x+y), gcd(Q,xy)=1",
            "k6_divisibility": "Q divides 32 and Q mod 16 belongs to {4,8}",
            "closed_value_sets": {str(k): sorted(values) for k, values in EXPECTED_VALUES.items()},
        },
        "attainment_witnesses": witnesses,
        "odd_residue_check": residues,
        "primitive_k6_check": primitive,
        "bounded_scan": scan,
        "checks": checks,
        "environment": {
            "python": platform.python_version(),
            "script_sha256": sha256_bytes(Path(__file__).read_bytes()),
        },
    }
    payload["payload_sha256_without_self"] = sha256_bytes(
        json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
    )
    return payload


def main() -> None:
    payload = build_payload()
    if not all(payload["checks"].values()):
        raise SystemExit("one or more resolution checks failed")
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"wrote {OUTPUT_PATH.relative_to(PROJECT)}")


if __name__ == "__main__":
    main()
