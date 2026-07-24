#!/usr/bin/env python3
"""Separate dual-checker for Graffiti 284 on Hoffman–Singleton."""

from __future__ import annotations

import json


def distance_all_ones(n: int, k: int) -> int:
    return 2 * (n - 1) - k


def distance_from_adjacency(theta: int) -> int:
    return -2 - theta


def graffiti284(min_dual: int, lambda_min_d: int) -> bool:
    return min_dual <= -lambda_min_d


def verify_hoffman_singleton() -> dict[str, object]:
    n, k = 50, 7
    adj_restricted = [2, -3]
    dist_restricted = [distance_from_adjacency(t) for t in adj_restricted]
    all_ones = distance_all_ones(n, k)
    lambda_min = min(dist_restricted)
    min_dual = k  # regular
    assert all_ones == 91
    assert dist_restricted == [-4, 1]
    assert lambda_min == -4
    assert min_dual == 7
    assert graffiti284(min_dual, lambda_min) is False
    assert min_dual + lambda_min == 3
    return {
        "graph": "Hoffman-Singleton",
        "order": n,
        "degree": k,
        "girth": 5,
        "diameter": 2,
        "adjacency_spectrum": {"7": 1, "2": 28, "-3": 21},
        "distance_spectrum": {"91": 1, "1": 21, "-4": 28},
        "min_dual": min_dual,
        "lambda_min_D": lambda_min,
        "graffiti284_holds": False,
        "margin_min_dual_plus_lambda_min": min_dual + lambda_min,
    }


def verify_petersen_control() -> dict[str, object]:
    n, k = 10, 3
    adj_restricted = [1, -2]
    dist_restricted = [distance_from_adjacency(t) for t in adj_restricted]
    all_ones = distance_all_ones(n, k)
    lambda_min = min(dist_restricted)
    min_dual = k
    assert all_ones == 15
    assert dist_restricted == [-3, 0]
    assert lambda_min == -3
    assert graffiti284(min_dual, lambda_min) is True
    assert min_dual + lambda_min == 0
    return {
        "graph": "Petersen",
        "order": n,
        "degree": k,
        "min_dual": min_dual,
        "lambda_min_D": lambda_min,
        "graffiti284_holds": True,
        "margin_min_dual_plus_lambda_min": 0,
        "role": "tight non-counterexample control",
    }


def main() -> None:
    hs = verify_hoffman_singleton()
    petersen = verify_petersen_control()
    result = {
        "schema_version": "2026-07-23.graffiti284_hoffman_singleton.v1",
        "source": (
            "Graffiti / Written on the Wall conjecture 284 "
            "(min_dual <= -lambda_min(D), connected girth >= 5)"
        ),
        "hoffman_singleton": hs,
        "petersen_control": petersen,
        "claim_boundary": (
            "Algebraic diameter-2 bridge plus classical Hoffman-Singleton "
            "adjacency spectrum refute the usual numerical reading of "
            "Graffiti 284. Lean does not construct the graph; public statement "
            "proxies are sealed under data/source_seals/; the Fajtlowicz WoW "
            "master list remains an external request-only remainder."
        ),
        "all_pass": True,
    }
    print(json.dumps(result, sort_keys=True, separators=(",", ":")))


if __name__ == "__main__":
    main()
