#!/usr/bin/env python3
"""Reproduce the finite n=7 abelian-group minimum-order computation.

This verifier compiles two separately implemented C++ exhaustive searches,
regenerates all finite abelian group types of orders 35 through 63 from primary
decomposition, requires complete exhaustion of every type, compares the two
searches exactly, and directly checks the known order-64 construction in
(Z/2Z)^6 against all C(13, 6) multiplicity vectors.
"""

from __future__ import annotations

import hashlib
import itertools
import json
import math
import os
import subprocess
import sys
import tempfile
from pathlib import Path


HERE = Path(__file__).resolve().parent
SEARCH_SOURCE = HERE / "unique_multiset_group_search.cpp"
CROSSCHECK_SOURCE = HERE / "unique_multiset_group_crosscheck.cpp"


def factor(number: int) -> list[tuple[int, int]]:
    result: list[tuple[int, int]] = []
    prime = 2
    while prime * prime <= number:
        if number % prime == 0:
            exponent = 0
            while number % prime == 0:
                number //= prime
                exponent += 1
            result.append((prime, exponent))
        prime += 1
    if number > 1:
        result.append((number, 1))
    return result


def partitions(total: int, maximum: int | None = None):
    if total == 0:
        yield ()
        return
    maximum = min(total, maximum or total)
    for first in range(maximum, 0, -1):
        for tail in partitions(total - first, first):
            yield (first,) + tail


def abelian_group_types(order: int):
    primary_choices: list[list[tuple[int, ...]]] = []
    for prime, exponent in factor(order):
        primary_choices.append(
            [
                tuple(prime**part for part in partition)
                for partition in partitions(exponent)
            ]
        )
    for selection in itertools.product(*primary_choices):
        yield tuple(component for primary in selection for component in primary)


def compositions(total: int, slots: int):
    if slots == 1:
        yield (total,)
        return
    for first in range(total + 1):
        for tail in compositions(total - first, slots - 1):
            yield (first,) + tail


def verify_order_64_construction() -> dict[str, int | bool]:
    # g_0 = 0 and g_i = e_i for 1 <= i <= 6 in F_2^6.
    elements = [0] + [1 << coordinate for coordinate in range(6)]
    target = 0
    for element in elements:
        target ^= element

    matches: list[tuple[int, ...]] = []
    checked = 0
    for multiplicities in compositions(7, 7):
        checked += 1
        value = 0
        for element, multiplicity in zip(elements, multiplicities):
            if multiplicity % 2:
                value ^= element
        if value == target:
            matches.append(multiplicities)

    assert checked == math.comb(13, 6)
    assert matches == [(1, 1, 1, 1, 1, 1, 1)]
    return {
        "order": 64,
        "multiplicity_vectors_checked": checked,
        "target_preimages": len(matches),
        "verified": True,
    }


def main() -> int:
    group_types = [
        group_type
        for order in range(35, 64)
        for group_type in abelian_group_types(order)
    ]
    assert len(group_types) == 49

    with tempfile.TemporaryDirectory(prefix="unique-multiset-n7-") as directory:
        executable = Path(directory) / "search"
        crosscheck_executable = Path(directory) / "crosscheck"
        subprocess.run(
            [
                "clang++",
                "-std=c++20",
                "-O3",
                "-Wall",
                "-Wextra",
                "-pedantic",
                str(SEARCH_SOURCE),
                "-o",
                str(executable),
            ],
            check=True,
        )
        subprocess.run(
            [
                "clang++",
                "-std=c++20",
                "-O3",
                "-Wall",
                "-Wextra",
                "-Werror",
                "-pedantic",
                str(CROSSCHECK_SOURCE),
                "-o",
                str(crosscheck_executable),
            ],
            check=True,
        )

        records: list[dict[str, object]] = []
        unpruned_records: list[dict[str, object]] = []
        crosscheck_records: list[dict[str, object]] = []
        for position, group_type in enumerate(group_types, start=1):
            completed = subprocess.run(
                [str(executable), *map(str, group_type)],
                check=True,
                capture_output=True,
                text=True,
            )
            record = json.loads(completed.stdout)
            assert record["status"] == "exhausted", record
            assert record["order"] == math.prod(group_type), record
            assert record["prefix_pruning"] is True, record
            records.append(record)

            unpruned_environment = dict(os.environ)
            unpruned_environment["DISABLE_PREFIX_PRUNING"] = "1"
            unpruned = subprocess.run(
                [str(executable), *map(str, group_type)],
                check=True,
                capture_output=True,
                text=True,
                env=unpruned_environment,
            )
            unpruned_record = json.loads(unpruned.stdout)
            assert unpruned_record["status"] == "exhausted", unpruned_record
            assert unpruned_record["order"] == math.prod(group_type), unpruned_record
            assert unpruned_record["prefix_pruning"] is False, unpruned_record
            unpruned_records.append(unpruned_record)

            separate = subprocess.run(
                [str(crosscheck_executable), *map(str, group_type)],
                check=True,
                capture_output=True,
                text=True,
            )
            crosscheck_record = json.loads(separate.stdout)
            assert crosscheck_record["status"] == "exhausted", crosscheck_record
            assert crosscheck_record["order"] == math.prod(group_type), crosscheck_record
            assert crosscheck_record["nodes"] == unpruned_record["nodes"], (
                crosscheck_record,
                unpruned_record,
            )
            assert crosscheck_record["full_candidates"] == unpruned_record[
                "full_candidates"
            ], (crosscheck_record, unpruned_record)
            crosscheck_records.append(crosscheck_record)
            print(
                f"exhausted group type {position}/{len(group_types)}",
                file=sys.stderr,
                flush=True,
            )

    construction = verify_order_64_construction()
    source_digest = hashlib.sha256(SEARCH_SOURCE.read_bytes()).hexdigest()
    crosscheck_digest = hashlib.sha256(CROSSCHECK_SOURCE.read_bytes()).hexdigest()
    summary = {
        "claim": "minimum_order_for_seven_elements_is_64",
        "lower_bound": {
            "orders_below_35": "excluded_by_35_distinct_three_subset_sums",
            "orders_exhaustively_checked": [35, 63],
            "abelian_group_type_count": len(records),
            "all_types_exhausted": all(
                record["status"] == "exhausted" for record in records
            ),
            "total_search_nodes": sum(int(record["nodes"]) for record in records),
            "prefix_unique_seven_sets": sum(
                int(record["full_candidates"]) for record in records
            ),
            "unpruned_primary_search": {
                "all_types_exhausted": all(
                    record["status"] == "exhausted"
                    for record in unpruned_records
                ),
                "total_search_nodes": sum(
                    int(record["nodes"]) for record in unpruned_records
                ),
                "directly_checked_seven_sets": sum(
                    int(record["full_candidates"])
                    for record in unpruned_records
                ),
                "valid_sets_found": 0,
            },
            "independent_implementation_crosscheck": {
                "all_types_exhausted": all(
                    record["status"] == "exhausted"
                    for record in crosscheck_records
                ),
                "total_search_nodes": sum(
                    int(record["nodes"]) for record in crosscheck_records
                ),
                "directly_checked_seven_sets": sum(
                    int(record["full_candidates"])
                    for record in crosscheck_records
                ),
                "exact_count_match_with_unpruned_primary": all(
                    crosscheck["nodes"] == primary["nodes"]
                    and crosscheck["full_candidates"]
                    == primary["full_candidates"]
                    for crosscheck, primary in zip(
                        crosscheck_records, unpruned_records
                    )
                ),
                "valid_sets_found": 0,
            },
        },
        "upper_bound": construction,
        "search_source_sha256": source_digest,
        "crosscheck_source_sha256": crosscheck_digest,
        "verified": True,
    }
    print(json.dumps(summary, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
