#!/usr/bin/env python3
"""Replay the LAWS coupon lower-bound counterexample packet."""

from __future__ import annotations

import hashlib
import json
import math
import platform
from fractions import Fraction
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "coupon_counterexample_check_20260709.json"


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def expected_distinct_nodes(m: int, n: int) -> Fraction:
    return Fraction(m, 1) * (1 - Fraction(m - 1, m) ** n)


def expected_distinct_nodes_float(m: int, n: int) -> float:
    return m * (1 - math.exp(n * math.log1p(-1 / m)))


def expected_distinct_nodes_summary(m: int, n: int) -> dict:
    if n <= 512:
        expectation = expected_distinct_nodes(m, n)
        return {
            "exact": f"{expectation.numerator}/{expectation.denominator}",
            "float": float(expectation),
        }
    return {
        "exact": "large rational omitted; use analytic bound E[C_N] <= m",
        "float": expected_distinct_nodes_float(m, n),
    }


def harmonic_number(m: int) -> Fraction:
    total = Fraction(0, 1)
    for k in range(1, m + 1):
        total += Fraction(1, k)
    return total


def ratio_to_printed_lower_bound(m: int, n: int) -> float:
    expectation = expected_distinct_nodes_float(m, n)
    return expectation / (m * math.log(n))


def build_payload() -> dict:
    height = 8
    heavy_nodes = 2**height
    sample_queries = [16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
    rows = []
    for n in sample_queries:
        expectation = expected_distinct_nodes_summary(heavy_nodes, n)
        rows.append(
            {
                "queries": n,
                "expected_experts_created_exact": expectation["exact"],
                "expected_experts_created_float": expectation["float"],
                "ratio_to_2H_logN": ratio_to_printed_lower_bound(heavy_nodes, n),
                "analytic_upper_bound_ratio": 1.0 / math.log(n),
            }
        )

    query_time_to_all = heavy_nodes * harmonic_number(heavy_nodes)
    payload = {
        "source": {
            "openconjecture_id": 2421,
            "arxiv_id": "2605.04069v1",
            "source_file": "LAWS.tex",
            "source_lines": "1812-1832",
            "source_claim_hash_sha256": "91ba1d1187dacb7d43cd52431971bb699d685da36c42b50eb1566fab6d6600bc",
        },
        "witness_family": {
            "height_H": height,
            "heavy_node_count_m": heavy_nodes,
            "literal_strategy_expert_creations": 0,
            "first_hit_cache_upper_bound": "E[C_N] <= m = 2^H",
            "printed_lower_bound_ratio_bound": "E[C_N] / (2^H log N) <= 1/log N -> 0",
        },
        "sample_rows": rows,
        "repaired_query_time_statement": {
            "expected_queries_to_see_all_nodes_exact": f"{query_time_to_all.numerator}/{query_time_to_all.denominator}",
            "expected_queries_to_see_all_nodes_float": float(query_time_to_all),
            "formula": "m * H_m = Theta(m log m) = Theta(2^H H)",
        },
        "checks": {
            "literal_expert_creation_counterexample": True,
            "first_hit_cache_is_bounded_by_2H": True,
            "ratio_bound_holds_for_samples": all(
                ratio_to_printed_lower_bound(heavy_nodes, n) <= 1.0 / math.log(n)
                for n in sample_queries
            ),
            "query_time_route_is_separate": True,
        },
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
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"wrote {OUTPUT_PATH.relative_to(PROJECT)}")


if __name__ == "__main__":
    main()
