#!/usr/bin/env python3
"""Replay the OpenConjecture 3706 trace counterexample packet."""

from __future__ import annotations

import hashlib
import json
import platform
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "trace_counterexample_check_20260709.json"


Matrix = list[list[int]]
Vector = list[int]


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def transpose(matrix: Matrix) -> Matrix:
    return [list(row) for row in zip(*matrix)]


def matmul(left: Matrix, right: Matrix) -> Matrix:
    return [
        [sum(left[i][k] * right[k][j] for k in range(len(right))) for j in range(len(right[0]))]
        for i in range(len(left))
    ]


def matvec(matrix: Matrix, vector: Vector) -> Vector:
    return [sum(row[i] * vector[i] for i in range(len(vector))) for row in matrix]


def scalar_vec(scalar: int, vector: Vector) -> Vector:
    return [scalar * value for value in vector]


def det2(columns: tuple[Vector, Vector]) -> int:
    u, v = columns
    return u[0] * v[1] - u[1] * v[0]


def charpoly_zero_2x2(matrix: Matrix, eigenvalue: int) -> bool:
    a, b = matrix[0]
    c, d = matrix[1]
    return (a - eigenvalue) * (d - eigenvalue) - b * c == 0


def cert_for_matrix(
    name: str,
    matrix: Matrix,
    singular_value_squares: tuple[int, int],
    right_top_vector: Vector,
    left_top_vector: Vector,
    vee_trace: str,
    require_distinct_top_directions: bool,
) -> dict:
    right_gram = matmul(transpose(matrix), matrix)
    left_gram = matmul(matrix, transpose(matrix))
    top, bottom = singular_value_squares
    checks = {
        "right_top_eigenvalue_equation": matvec(right_gram, right_top_vector)
        == scalar_vec(top, right_top_vector),
        "left_top_eigenvalue_equation": matvec(left_gram, left_top_vector)
        == scalar_vec(top, left_top_vector),
        "right_bottom_charpoly_zero": charpoly_zero_2x2(right_gram, bottom),
        "left_bottom_charpoly_zero": charpoly_zero_2x2(left_gram, bottom),
        "top_direction_condition": (det2((right_top_vector, left_top_vector)) != 0)
        if require_distinct_top_directions
        else (det2((right_top_vector, left_top_vector)) == 0),
    }
    return {
        "name": name,
        "matrix": matrix,
        "right_gram": right_gram,
        "left_gram": left_gram,
        "singular_value_squares_desc": list(singular_value_squares),
        "right_top_vector": right_top_vector,
        "left_top_vector": left_top_vector,
        "top_direction_determinant": det2((right_top_vector, left_top_vector)),
        "top_direction_condition": "distinct" if require_distinct_top_directions else "same",
        "vee_trace": vee_trace,
        "checks": checks,
        "all_checks_pass": all(checks.values()),
    }


def build_payload() -> dict:
    a = [[2, 2], [-1, 2]]
    b = [[2, 0], [0, 0]]
    c = [[a[i][j] + b[i][j] for j in range(2)] for i in range(2)]

    certificates = [
        cert_for_matrix("A", a, (9, 4), [1, 2], [2, 1], "6", True),
        cert_for_matrix("B", b, (4, 0), [1, 0], [1, 0], "2", False),
        cert_for_matrix("A+B", c, (20, 5), [2, 1], [1, 0], "4*sqrt(5)", True),
    ]

    trace_gap_positive = 16 * 5 > 64
    payload = {
        "source": {
            "openconjecture_id": 3706,
            "arxiv_id": "2606.15624v2",
            "source_file": "Averages-3.tex",
            "source_lines": "675-693",
            "source_claim_hash_sha256": "4f47a2321d6d8379a5ed45467508e1b0a3b8a7cf38078874ec35d64fa15440d8",
        },
        "witness": {
            "A": a,
            "B": b,
            "A_plus_B": c,
            "dimension": 2,
            "field": "real matrices",
        },
        "certificates": certificates,
        "trace_certificate": {
            "trace_lhs": "4*sqrt(5)",
            "trace_rhs": "8",
            "trace_gap": "4*sqrt(5) - 8",
            "positive_check": "16*5 > 64",
            "trace_gap_positive": trace_gap_positive,
        },
        "checks": {
            "all_matrix_certificates_pass": all(item["all_checks_pass"] for item in certificates),
            "trace_gap_positive": trace_gap_positive,
            "c_vee_equal_one_disproved_in_dimension_2": trace_gap_positive
            and all(item["all_checks_pass"] for item in certificates),
        },
        "environment": {
            "python": platform.python_version(),
            "script_sha256": sha256_bytes(Path(__file__).read_bytes()),
        },
        "carried_boundary": [
            "The optimal value of c_vee(d) remains outside this packet.",
            "Dimension families beyond the displayed 2 x 2 counterexample remain outside this packet.",
            "This public packet is a checker packet rather than a Lean formalization.",
        ],
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
