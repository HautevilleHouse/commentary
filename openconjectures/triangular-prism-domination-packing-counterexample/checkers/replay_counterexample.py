#!/usr/bin/env python3
"""Replay the OpenConjecture 4867 triangular-prism counterexample."""

from __future__ import annotations

import hashlib
import itertools
import json
import platform
from collections import deque
from fractions import Fraction
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "counterexample_check_20260717.json"
VERTICES = tuple(range(6))
EDGES = (
    (0, 1),
    (0, 2),
    (0, 3),
    (1, 2),
    (1, 4),
    (2, 5),
    (3, 4),
    (3, 5),
    (4, 5),
)


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def adjacency(edges: tuple[tuple[int, int], ...] = EDGES) -> dict[int, set[int]]:
    result = {vertex: set() for vertex in VERTICES}
    for left, right in edges:
        result[left].add(right)
        result[right].add(left)
    return result


def connected(edges: tuple[tuple[int, int], ...] = EDGES) -> bool:
    graph = adjacency(edges)
    reached = {VERTICES[0]}
    queue = deque(reached)
    while queue:
        vertex = queue.popleft()
        for neighbor in graph[vertex]:
            if neighbor not in reached:
                reached.add(neighbor)
                queue.append(neighbor)
    return reached == set(VERTICES)


def distances(start: int, graph: dict[int, set[int]]) -> dict[int, int]:
    result = {start: 0}
    queue = deque([start])
    while queue:
        vertex = queue.popleft()
        for neighbor in graph[vertex]:
            if neighbor not in result:
                result[neighbor] = result[vertex] + 1
                queue.append(neighbor)
    return result


def dominating(subset: tuple[int, ...], graph: dict[int, set[int]]) -> bool:
    covered = set(subset)
    for vertex in subset:
        covered.update(graph[vertex])
    return covered == set(VERTICES)


def packing(
    subset: tuple[int, ...], distance_table: dict[int, dict[int, int]]
) -> bool:
    pairs = itertools.combinations(subset, 2)
    return all(distance_table[left][right] >= 3 for left, right in pairs)


def extremal_subsets(predicate, *, minimize: bool) -> tuple[int, list[tuple[int, ...]]]:
    sizes = (
        range(len(VERTICES) + 1)
        if minimize
        else range(len(VERTICES), -1, -1)
    )
    for size in sizes:
        candidates = itertools.combinations(VERTICES, size)
        witnesses = [subset for subset in candidates if predicate(subset)]
        if witnesses:
            return size, witnesses
    raise AssertionError("finite subset enumeration produced no witness")


def induced_claws(graph: dict[int, set[int]]) -> list[dict[str, object]]:
    claws = []
    for center in VERTICES:
        for leaves in itertools.combinations(sorted(graph[center]), 3):
            leaf_pairs = itertools.combinations(leaves, 2)
            if all(right not in graph[left] for left, right in leaf_pairs):
                claws.append({"center": center, "leaves": list(leaves)})
    return claws


def build_payload() -> dict:
    graph = adjacency()
    distance_table = {vertex: distances(vertex, graph) for vertex in VERTICES}
    gamma, minimum_dominating_sets = extremal_subsets(
        lambda subset: dominating(subset, graph), minimize=True
    )
    rho, maximum_packings = extremal_subsets(
        lambda subset: packing(subset, distance_table), minimize=False
    )
    claws = induced_claws(graph)
    edge_deletion_checks = {}
    for removed_edge in EDGES:
        remaining_edges = tuple(edge for edge in EDGES if edge != removed_edge)
        left, right = removed_edge
        edge_deletion_checks[f"{left}-{right}"] = connected(remaining_edges)
    diameter = max(max(row.values()) for row in distance_table.values())
    conjectured_bound = Fraction(5, 4) * rho
    proved_bound = Fraction(7, 4) * rho + Fraction(5, 6)
    checks = {
        "simple_graph": len(EDGES) == len(set(EDGES))
        and all(left < right for left, right in EDGES),
        "connected": connected(),
        "cubic": all(len(graph[vertex]) == 3 for vertex in VERTICES),
        "bridgeless": all(edge_deletion_checks.values()),
        "claw_free": not claws,
        "diameter_is_two": diameter == 2,
        "domination_number_is_two": gamma == 2,
        "packing_number_is_one": rho == 1,
        "conjectured_bound_is_violated": Fraction(gamma) > conjectured_bound,
        "source_proved_bound_is_preserved": Fraction(gamma) <= proved_bound,
    }
    payload = {
        "source": {
            "openconjecture_id": 4867,
            "arxiv_id": "2606.29199v1",
            "source_file": "intro.tex",
            "definition_lines": "7",
            "conjecture_lines": "76-81",
            "source_definition_sha256": (
                "338f3d58cb3d45438aed0c0b0d3408f085ed460a82ea77cc53385579717b8b33"
            ),
            "source_conjecture_sha256": (
                "7d91c1c83d344bcdfaa2a7dfab8b170fc5367b6f3f8c82e86339d64c0954d731"
            ),
        },
        "graph": {
            "name": "triangular prism",
            "vertices": list(VERTICES),
            "edges": [list(edge) for edge in EDGES],
            "degrees": {str(vertex): len(graph[vertex]) for vertex in VERTICES},
            "diameter": diameter,
            "induced_claws": claws,
            "connected_after_edge_deletion": edge_deletion_checks,
        },
        "invariants": {
            "domination_number": gamma,
            "minimum_dominating_sets": [
                list(subset) for subset in minimum_dominating_sets
            ],
            "packing_number": rho,
            "maximum_packings": [list(subset) for subset in maximum_packings],
        },
        "bounds": {
            "conjectured": "gamma <= (5/4)*rho",
            "conjectured_rhs": str(conjectured_bound),
            "proved_in_source": "gamma <= (7/4)*rho + 5/6",
            "proved_rhs": str(proved_bound),
        },
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
        failed = [name for name, result in payload["checks"].items() if not result]
        raise SystemExit(f"counterexample checks failed: {', '.join(failed)}")
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"wrote {OUTPUT_PATH.relative_to(PROJECT)}")


if __name__ == "__main__":
    main()
