#!/usr/bin/env python3
"""Replay the C3 avalanche counterexample with separate checks."""

from __future__ import annotations

import hashlib
import json
import pathlib
import shutil
import subprocess
import tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
TARGET = (1, 0, 1)
EDGES = ((0, 1), (1, 2), (2, 0))


def parallel_step(
    configuration: tuple[int, ...], edges: tuple[tuple[int, int], ...]
) -> tuple[tuple[int, ...], tuple[int, ...]]:
    """Apply the paper's parallel-firing rule directly from directed edges."""
    n = len(configuration)
    out_degree = [0] * n
    for source, _target in edges:
        out_degree[source] += 1
    firing = tuple(
        vertex
        for vertex, grains in enumerate(configuration)
        if grains >= out_degree[vertex]
    )
    next_configuration = list(configuration)
    firing_set = set(firing)
    for source in firing:
        next_configuration[source] -= out_degree[source]
    for source, target in edges:
        if source in firing_set:
            next_configuration[target] += 1
    return firing, tuple(next_configuration)


def complete_orbit(
    initial: tuple[int, ...], edges: tuple[tuple[int, int], ...]
) -> tuple[list[tuple[int, ...]], list[tuple[int, ...]]]:
    states: list[tuple[int, ...]] = []
    firing_sets: list[tuple[int, ...]] = []
    seen: set[tuple[int, ...]] = set()
    current = initial
    while current not in seen:
        seen.add(current)
        states.append(current)
        firing, current = parallel_step(current, edges)
        firing_sets.append(firing)
    assert current == initial
    return states, firing_sets


def downward_closure(facets: list[tuple[int, ...]]) -> list[set[tuple[int, ...]]]:
    dimensions: list[set[tuple[int, ...]]] = [set() for _ in range(3)]
    for facet in facets:
        mask = sum(1 << vertex for vertex in facet)
        submask = mask
        while submask:
            simplex = tuple(vertex for vertex in range(3) if submask >> vertex & 1)
            dimensions[len(simplex) - 1].add(simplex)
            submask = (submask - 1) & mask
    return dimensions


def gf2_rank(columns: list[int]) -> int:
    pivots: dict[int, int] = {}
    rank = 0
    for column in columns:
        value = column
        while value:
            pivot = value.bit_length() - 1
            if pivot in pivots:
                value ^= pivots[pivot]
            else:
                pivots[pivot] = value
                rank += 1
                break
    return rank


def betti_numbers(simplices: list[set[tuple[int, ...]]]) -> tuple[int, ...]:
    boundary_ranks = [0] * len(simplices)
    for dimension in range(1, len(simplices)):
        lower = sorted(simplices[dimension - 1])
        lower_index = {simplex: index for index, simplex in enumerate(lower)}
        columns: list[int] = []
        for simplex in sorted(simplices[dimension]):
            column = 0
            for removed in range(len(simplex)):
                face = simplex[:removed] + simplex[removed + 1 :]
                column |= 1 << lower_index[face]
            columns.append(column)
        boundary_ranks[dimension] = gf2_rank(columns)
    return tuple(
        len(simplices[dimension])
        - boundary_ranks[dimension]
        - (
            boundary_ranks[dimension + 1]
            if dimension + 1 < len(simplices)
            else 0
        )
        for dimension in range(len(simplices))
    )


def run_crosscheck() -> dict[str, str]:
    compiler = shutil.which("clang++") or shutil.which("g++")
    if compiler is None:
        raise RuntimeError("a C++20 compiler is required")
    with tempfile.TemporaryDirectory(prefix="avalanche-crosscheck-") as tmp:
        binary = pathlib.Path(tmp) / "crosscheck"
        subprocess.run(
            [
                compiler,
                "-std=c++20",
                "-O2",
                "-Wall",
                "-Wextra",
                "-pedantic",
                str(ROOT / "checkers/crosscheck.cpp"),
                "-o",
                str(binary),
            ],
            check=True,
        )
        output = subprocess.run(
            [str(binary)], check=True, capture_output=True, text=True
        ).stdout
    return dict(line.split("=", 1) for line in output.strip().splitlines())


def validate_receipt() -> None:
    receipt = json.loads((ROOT / "data/replay_receipt.json").read_text())
    assert receipt["schema"] == "public-proof-packet-replay.v1"
    for relative, expected in receipt["files"].items():
        actual = hashlib.sha256((ROOT / relative).read_bytes()).hexdigest()
        if actual != expected:
            raise AssertionError(f"hash mismatch: {relative}")


def main() -> int:
    source = json.loads((ROOT / "data/source_identity.json").read_text())
    assert source["openconjecture_id"] == 4244
    assert source["arxiv"]["identifier"] == "2606.26786v1"

    states, firing_sets = complete_orbit(TARGET, EDGES)
    assert states == [(1, 0, 1), (1, 1, 0), (0, 1, 1)]
    assert firing_sets == [(0, 2), (0, 1), (1, 2)]

    simplices = downward_closure(firing_sets)
    assert simplices[0] == {(0,), (1,), (2,)}
    assert simplices[1] == {(0, 1), (0, 2), (1, 2)}
    assert simplices[2] == set()
    betti = betti_numbers(simplices)
    assert betti == (1, 1, 0)
    assert betti != (2, 0, 0)  # ordinary Betti numbers of S^0

    crosscheck = run_crosscheck()
    expected_crosscheck = {
        "orbit_masks": "5,3,6",
        "vertices": "3",
        "edges": "3",
        "triangles": "0",
        "components": "1",
        "beta0": "1",
        "beta1": "1",
        "predicted_dimension": "0",
        "predicted_components": "2",
    }
    assert crosscheck == expected_crosscheck

    result = {
        "admitted": True,
        "configuration": list(TARGET),
        "cpp": expected_crosscheck,
        "firing_sets_one_based": [
            [vertex + 1 for vertex in facet] for facet in firing_sets
        ],
        "observed_betti_f2": list(betti),
        "predicted_sphere": "S^0",
        "source_hypotheses": {
            "binary": True,
            "i": 2,
            "k": 2,
            "n": 3,
            "total_grains_gt_one": True,
            "zero_positions": [2],
        },
    }
    recorded = json.loads(
        (ROOT / "data/verification_result_20260718.json").read_text()
    )
    assert recorded["result"] == result
    validate_receipt()
    print(json.dumps(result, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
