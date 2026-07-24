#!/usr/bin/env python3
"""Replay the source-exact S-LCG maximum-generator counterexample."""

from __future__ import annotations

import json


def slcg_step(n: int, x: int) -> int:
    return (2 * x + 1) % (2**n + 1)


def predicted_maximum(n: int) -> int:
    assert n >= 3 and n % 2 == 1
    return 4 * (4 ** ((n - 3) // 2) - 1) // 3


def two_cycle_family(n: int) -> tuple[int, int]:
    assert n >= 3 and n % 2 == 1
    return ((2**n - 2) // 3, (2 ** (n + 1) - 1) // 3)


def verify_family(n: int) -> dict[str, int]:
    modulus = 2**n + 1
    a, b = two_cycle_family(n)
    predicted = predicted_maximum(n)
    assert (2**n - 2) % 3 == 0
    assert (2 ** (n + 1) - 1) % 3 == 0
    assert 0 <= a < b < 2**n
    assert slcg_step(n, a) == b
    assert slcg_step(n, b) == a
    assert predicted == (2 ** (n - 1) - 4) // 3
    assert a - predicted == (2 ** (n - 1) + 2) // 3
    assert a > predicted
    return {
        "n": n,
        "modulus": modulus,
        "cycle_minimum": a,
        "cycle_maximum": b,
        "predicted_maximum": predicted,
        "gap": a - predicted,
    }


def exhaustive_cycle_partition(n: int) -> dict[str, object]:
    """Enumerate the source's n-bit cycles, excluding only the extra fixed residue 2^n."""

    state_count = 2**n
    visited = [False] * state_count
    cycles: list[list[int]] = []
    for start in range(state_count):
        if visited[start]:
            continue
        cycle: list[int] = []
        x = start
        while not visited[x]:
            assert 0 <= x < state_count
            visited[x] = True
            cycle.append(x)
            x = slcg_step(n, x)
        assert x == start
        cycles.append(cycle)

    generators = [min(cycle) for cycle in cycles]
    actual_maximum = max(generators)
    maximal_cycle = cycles[generators.index(actual_maximum)]
    family_minimum, family_maximum = two_cycle_family(n)
    assert actual_maximum == family_minimum
    assert set(maximal_cycle) == {family_minimum, family_maximum}
    assert actual_maximum > predicted_maximum(n)
    return {
        "n": n,
        "cycle_count": len(cycles),
        "actual_maximum_generator": actual_maximum,
        "predicted_maximum": predicted_maximum(n),
        "maximal_generator_cycle": maximal_cycle,
    }


def main() -> None:
    family_checks = [verify_family(n) for n in range(3, 100, 2)]
    exhaustive_checks = [
        exhaustive_cycle_partition(n) for n in range(3, 20, 2)
    ]

    n7 = verify_family(7)
    assert n7 == {
        "n": 7,
        "modulus": 129,
        "cycle_minimum": 42,
        "cycle_maximum": 85,
        "predicted_maximum": 20,
        "gap": 22,
    }

    result = {
        "schema_version": "2026-07-18.slcg_maximum_generator_counterexample.v1",
        "source": "arXiv:2605.05198v1, Maximum Generator conjecture",
        "counterexample": n7,
        "general_two_cycle_family": {
            "odd_n_min": 3,
            "odd_n_max_checked": 99,
            "instances_checked": len(family_checks),
            "all_exceed_the_conjectured_value": True,
        },
        "exhaustive_cycle_partitions": exhaustive_checks,
        "claim_boundary": (
            "The printed universal maximum-generator formula is false under "
            "the source cycle-minimum definition. No claim is made about a "
            "repaired definition that excludes short cycles."
        ),
        "all_pass": True,
    }
    print(json.dumps(result, sort_keys=True, separators=(",", ":")))


if __name__ == "__main__":
    main()
