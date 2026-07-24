#!/usr/bin/env python3
"""Replay the OpenConjecture 3659 boundary counterexample."""

from __future__ import annotations

import hashlib
import json
import platform
from functools import cache
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "counterexample_check_20260717.json"
SCAN_MAX_R = 9


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def conjugate(partition: tuple[int, ...]) -> tuple[int, ...]:
    if not partition:
        return ()
    return tuple(
        sum(value >= column for value in partition)
        for column in range(1, partition[0] + 1)
    )


def row_options(partition: tuple[int, ...]) -> set[tuple[int, ...]]:
    return {
        partition[:index] + partition[index + 1 :]
        for index in range(len(partition))
    }


def options(partition: tuple[int, ...]) -> set[tuple[int, ...]]:
    result = row_options(partition)
    transposed = conjugate(partition)
    result.update(conjugate(option) for option in row_options(transposed))
    return result


@cache
def grundy(partition: tuple[int, ...]) -> int:
    option_values = {grundy(option) for option in options(partition)}
    value = 0
    while value in option_values:
        value += 1
    return value


def rectair(r: int, c: int, k: int) -> tuple[int, ...]:
    if not (0 <= k < min(r, c)):
        raise ValueError("rectair parameters fall outside the source domain")
    return (c,) * (r - k) + tuple(range(c - 1, c - k - 1, -1))


def printed_value(r: int, k: int) -> int:
    if r % 2 == 0 or k < r - 1:
        return 0
    if r in {3, 5} and k == r - 1:
        return 1
    return 2


def bounded_scan() -> dict:
    rows = []
    mismatches = []
    for r in range(1, SCAN_MAX_R + 1):
        for k in range(r):
            partition = rectair(r, r, k)
            actual = grundy(partition)
            expected = printed_value(r, k)
            row = {
                "r": r,
                "k": k,
                "partition": list(partition),
                "actual": actual,
                "printed": expected,
            }
            rows.append(row)
            if actual != expected:
                mismatches.append(row)
    return {
        "maximum_r": SCAN_MAX_R,
        "case_count": len(rows),
        "mismatches": mismatches,
        "grundy_state_count": grundy.cache_info().currsize,
    }


def build_payload() -> dict:
    witness = rectair(1, 1, 0)
    witness_options = options(witness)
    actual = grundy(witness)
    expected = printed_value(1, 0)
    scan = bounded_scan()
    expected_mismatch = {
        "r": 1,
        "k": 0,
        "partition": [1],
        "actual": 1,
        "printed": 2,
    }
    checks = {
        "parameters_satisfy_printed_domain": 0 <= 0 < 1,
        "rectair_is_one_cell_partition": witness == (1,),
        "only_distinct_option_is_empty": witness_options == {()},
        "empty_partition_value_is_zero": grundy(()) == 0,
        "witness_value_is_one": actual == 1,
        "printed_branch_value_is_two": expected == 2,
        "later_source_staircase_value_agrees": actual == 1,
        "bounded_scan_has_exact_boundary_mismatch": scan["mismatches"]
        == [expected_mismatch],
    }
    payload = {
        "source": {
            "openconjecture_id": 3659,
            "arxiv_id": "2606.16828v1",
            "source_file": "arXiv.tex",
            "source_lines": "1021-1030",
            "source_claim_body_sha256": "c6d863ece2e788f09c3107fbb175c2ba8818a4bee7c7d66b9d1bcfda6f99f3d9",
        },
        "witness": {
            "r": 1,
            "k": 0,
            "partition": list(witness),
            "distinct_options": [list(option) for option in sorted(witness_options)],
            "option_values": sorted({grundy(option) for option in witness_options}),
            "actual_value": actual,
            "printed_value": expected,
            "later_source_S1_value": 1,
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
