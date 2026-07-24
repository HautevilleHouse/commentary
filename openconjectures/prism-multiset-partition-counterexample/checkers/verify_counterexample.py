#!/usr/bin/env python3
"""Verify the P_8 five-part multiset-partition counterexample."""

from __future__ import annotations

import hashlib
import json
from collections import deque
from pathlib import Path


M = 8
VERTICES = tuple((layer, index) for layer in (0, 1) for index in range(M))
ANCHORS = ((0, 0), (0, 1), (0, 3), (0, 5))
PARTS = tuple(frozenset((anchor,)) for anchor in ANCHORS) + (
    frozenset(set(VERTICES) - set(ANCHORS)),
)


def neighbors(vertex: tuple[int, int]) -> tuple[tuple[int, int], ...]:
    layer, index = vertex
    return (
        (layer, (index - 1) % M),
        (layer, (index + 1) % M),
        (1 - layer, index),
    )


def distances_to_part(part: frozenset[tuple[int, int]]) -> dict[tuple[int, int], int]:
    distances = {vertex: 0 for vertex in part}
    queue = deque(part)
    while queue:
        vertex = queue.popleft()
        for neighbor in neighbors(vertex):
            if neighbor not in distances:
                distances[neighbor] = distances[vertex] + 1
                queue.append(neighbor)
    return distances


def representation(
    vertex: tuple[int, int],
    part_distances: tuple[dict[tuple[int, int], int], ...],
) -> tuple[int, ...]:
    return tuple(sorted(distances[vertex] for distances in part_distances))


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    assert len(VERTICES) == 16
    assert all(len(neighbors(vertex)) == 3 for vertex in VERTICES)
    assert all(PARTS)
    assert set().union(*PARTS) == set(VERTICES)
    assert sum(len(part) for part in PARTS) == len(VERTICES)

    part_distances = tuple(distances_to_part(part) for part in PARTS)
    representations = {
        vertex: representation(vertex, part_distances) for vertex in VERTICES
    }
    assert all(len(distances) == len(VERTICES) for distances in part_distances)
    assert len(set(representations.values())) == len(VERTICES)

    packet_root = Path(__file__).resolve().parents[1]
    output_path = packet_root / "data" / "counterexample_check_20260717.json"
    payload = {
        "claim": "The five displayed parts resolve the prism graph P_8.",
        "conclusion": "mpd(P_8) <= 5, contradicting the conjectured value 6.",
        "degree_set": sorted({len(neighbors(vertex)) for vertex in VERTICES}),
        "distinct_representation_count": len(set(representations.values())),
        "openconjecture_id": 4479,
        "part_count": len(PARTS),
        "part_sizes": [len(part) for part in PARTS],
        "parts": [
            [[layer, index] for layer, index in sorted(part)] for part in PARTS
        ],
        "representations": [
            {
                "representation": list(representations[vertex]),
                "vertex": list(vertex),
            }
            for vertex in VERTICES
        ],
        "source_arxiv_id": "2607.07407v1",
        "status": "counterexample_verified",
        "vertex_count": len(VERTICES),
    }
    output_path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    print(json.dumps(payload, indent=2, sort_keys=True))
    print(f"output_sha256={sha256(output_path)}")


if __name__ == "__main__":
    main()
