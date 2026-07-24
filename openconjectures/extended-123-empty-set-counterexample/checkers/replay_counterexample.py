#!/usr/bin/env python3
"""Replay the OpenConjecture 4736 displayed-statement counterexample."""

from __future__ import annotations

import hashlib
import json
import platform
from itertools import combinations
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "counterexample_check_20260717.json"
UNIVERSE_MAX = 8
N_MAX = 8


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def dilation(values: frozenset[int], multiplier: int) -> frozenset[int]:
    if multiplier < 1:
        raise ValueError("the source uses positive multipliers")
    return frozenset(multiplier * value for value in values)


def symmetric_dilation_difference(
    values: frozenset[int], n: int
) -> frozenset[int]:
    if n < 1:
        raise ValueError("the source convention is N={1,2,...}")
    result: set[int] = set()
    for multiplier in range(1, n + 1):
        result.symmetric_difference_update(dilation(values, multiplier))
    return frozenset(result)


def finite_subsets(values: range):
    values_tuple = tuple(values)
    for size in range(len(values_tuple) + 1):
        for subset in combinations(values_tuple, size):
            yield frozenset(subset)


def bounded_scan() -> dict:
    empty_mismatches = []
    nonempty_mismatches = []
    nonempty_case_count = 0
    for values in finite_subsets(range(1, UNIVERSE_MAX + 1)):
        for n in range(1, N_MAX + 1):
            result = symmetric_dilation_difference(values, n)
            if values:
                nonempty_case_count += 1
            if len(result) >= n:
                continue
            row = {
                "A": sorted(values),
                "n": n,
                "left_cardinality": len(result),
                "right_side": n,
            }
            if values:
                nonempty_mismatches.append(row)
            else:
                empty_mismatches.append(row)
    return {
        "universe": list(range(1, UNIVERSE_MAX + 1)),
        "maximum_n": N_MAX,
        "nonempty_case_count": nonempty_case_count,
        "empty_set_mismatches": empty_mismatches,
        "nonempty_mismatches": nonempty_mismatches,
    }


def build_payload() -> dict:
    witness = frozenset()
    n = 1
    result = symmetric_dilation_difference(witness, n)
    scan = bounded_scan()
    expected_empty_mismatches = [
        {"A": [], "n": value, "left_cardinality": 0, "right_side": value}
        for value in range(1, N_MAX + 1)
    ]
    checks = {
        "empty_set_is_finite_subset": all(value > 0 for value in witness),
        "n_is_positive_integer": n >= 1,
        "every_witness_dilation_is_empty": all(
            not dilation(witness, multiplier) for multiplier in range(1, n + 1)
        ),
        "symmetric_difference_is_empty": result == frozenset(),
        "left_cardinality_is_zero": len(result) == 0,
        "displayed_inequality_is_false": len(result) < n,
        "bounded_scan_has_exact_empty_mismatches": scan["empty_set_mismatches"]
        == expected_empty_mismatches,
        "bounded_scan_has_no_nonempty_mismatch": not scan["nonempty_mismatches"],
        "bounded_scan_nonempty_case_count_is_2040": scan["nonempty_case_count"]
        == 2040,
    }
    payload = {
        "source": {
            "openconjecture_id": 4736,
            "arxiv_id": "2607.00934v1",
            "source_file": "final_version.tex",
            "source_lines": "333-336",
            "source_claim_body_sha256": "92a4c9ac3858d8dacdc2181c0ed062db05f8ccb9b2615dca9b511d5b5ef6b458",
        },
        "witness": {
            "A": [],
            "n": n,
            "dilations": [[]],
            "symmetric_difference": sorted(result),
            "left_cardinality": len(result),
            "right_side": n,
            "displayed_inequality_holds": len(result) >= n,
        },
        "source_boundary": {
            "displayed_nonempty_condition_present": False,
            "preceding_problem_nonempty_condition_present": True,
            "large_n_theorem_nonempty_condition_present": True,
            "n_at_most_8_theorem_nonempty_condition_present": True,
            "g_n_definition_nonempty_condition_present": True,
        },
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
        raise SystemExit("one or more counterexample checks failed")
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"wrote {OUTPUT_PATH.relative_to(PROJECT)}")


if __name__ == "__main__":
    main()
