#!/usr/bin/env python3
"""Replay the OpenConjecture 746 strictness counterexample."""

from __future__ import annotations

import hashlib
import json
import platform
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "monotonicity_resolution_check_20260717.json"
VERTICES = (1, 2, 3)
EDGES = {frozenset((2, 3))}
BLOCK_COUNT = 2


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def set_partitions(values: tuple[int, ...]) -> list[tuple[tuple[int, ...], ...]]:
    """Enumerate set partitions in a deterministic canonical form."""
    partitions: list[tuple[tuple[int, ...], ...]] = [()]
    for value in values:
        next_partitions: list[tuple[tuple[int, ...], ...]] = []
        for partition in partitions:
            next_partitions.append(partition + ((value,),))
            for index in range(len(partition)):
                blocks = list(partition)
                blocks[index] = blocks[index] + (value,)
                next_partitions.append(tuple(blocks))
        partitions = next_partitions
    return partitions


def is_graphical_witness_partition(
    partition: tuple[tuple[int, ...], ...],
) -> bool:
    """Apply the source rules to the witness, whose only nontrivial block is an edge."""
    if len(partition) != BLOCK_COUNT:
        return False
    for block in partition:
        if len(block) == 1:
            continue
        if len(block) == 2 and frozenset(block) in EDGES:
            continue
        return False
    return True


def first_r_are_separate(
    partition: tuple[tuple[int, ...], ...], r: int
) -> bool:
    block_by_vertex = {
        vertex: block_index
        for block_index, block in enumerate(partition)
        for vertex in block
    }
    return len({block_by_vertex[vertex] for vertex in range(1, r + 1)}) == r


def encoded_partition(partition: tuple[tuple[int, ...], ...]) -> list[list[int]]:
    return [list(block) for block in partition]


def build_payload() -> dict:
    all_partitions = set_partitions(VERTICES)
    graphical = [
        partition
        for partition in all_partitions
        if is_graphical_witness_partition(partition)
    ]
    restricted = {
        r: [partition for partition in graphical if first_r_are_separate(partition, r)]
        for r in (1, 2)
    }
    expected = (((1,), (2, 3)),)

    payload = {
        "source": {
            "openconjecture_id": 746,
            "arxiv_id": "2602.02046v1",
            "source_file": "YaqMirV1__1___2_.tex",
            "source_lines": "1811-1818",
            "source_claim_body_sha256": "ae7faab8d3e948cc0f600bb241d0d582420c9f896e16065945d88c550f2a3788",
        },
        "general_result": {
            "restricted_class": "A_r = {pi in P_k(G): 1,...,r occupy distinct blocks}",
            "inclusion": "A_(r+1) subseteq A_r",
            "gap_identity": "|A_r|-|A_(r+1)| counts pi in A_r where r+1 shares a block with one of 1,...,r",
            "displayed_weak_chain_proved": True,
            "universal_strict_gloss": False,
        },
        "witness": {
            "vertices": list(VERTICES),
            "edges": [sorted(edge) for edge in EDGES],
            "k": BLOCK_COUNT,
            "all_set_partition_count": len(all_partitions),
            "graphical_k_partition_count": len(graphical),
            "graphical_k_partitions": [encoded_partition(partition) for partition in graphical],
            "restricted_counts": {str(r): len(partitions) for r, partitions in restricted.items()},
            "restricted_partitions": {
                str(r): [encoded_partition(partition) for partition in partitions]
                for r, partitions in restricted.items()
            },
        },
        "checks": {
            "all_three_vertex_set_partitions_enumerated": len(all_partitions) == 5,
            "unique_graphical_two_block_partition": tuple(graphical) == expected,
            "positive_count_at_r1": len(restricted[1]) == 1,
            "positive_count_at_r2": len(restricted[2]) == 1,
            "weak_inequality_holds": len(restricted[1]) >= len(restricted[2]),
            "strictness_fails": len(restricted[1]) == len(restricted[2]),
            "nonboundary_k_less_than_n": BLOCK_COUNT < len(VERTICES),
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
    if not all(payload["checks"].values()):
        raise SystemExit("one or more witness checks failed")
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"wrote {OUTPUT_PATH.relative_to(PROJECT)}")


if __name__ == "__main__":
    main()
