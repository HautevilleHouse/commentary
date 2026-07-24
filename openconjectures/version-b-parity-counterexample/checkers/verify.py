#!/usr/bin/env python3
"""Replay the Version B counterexample with two separate algorithms."""

from __future__ import annotations

import functools
import hashlib
import itertools
import json
import pathlib
import shutil
import subprocess
import tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
TARGET = (5,) * 7 + (6,) * 5
ALL_OPTION = (4,) * 7 + (5,) * 5


@functools.cache
def is_p(position: tuple[int, ...]) -> bool:
    for value in sorted(set(position)):
        child = list(position)
        child[child.index(value)] -= 1
        if child[0] == 0:
            child.pop(0)
        child.sort()
        if is_p(tuple(child)):
            return False
    if position:
        child = tuple(value - 1 for value in position if value > 1)
        if is_p(child):
            return False
    return True


def predicted_p(k: int, odd: int) -> bool:
    if k % 2:
        return odd % 2 == 0
    if k % 4 == 0:
        return (odd % 2 == 0 and odd <= k // 2 - 2) or (
            odd % 2 == 1 and k // 2 + 1 <= odd <= k - 1
        )
    return (odd % 2 == 0 and odd <= k // 2 - 1) or (
        odd % 2 == 1 and k // 2 + 2 <= odd <= k - 1
    )


def first_python_mismatch() -> tuple[tuple[int, ...], int]:
    checked = 0
    for position in itertools.combinations_with_replacement(range(5, 11), 12):
        checked += 1
        odd = sum(value % 2 for value in position)
        if is_p(position) != predicted_p(12, odd):
            return position, checked
    raise AssertionError("expected counterexample was not found")


def validate_receipt() -> None:
    receipt = json.loads((ROOT / "data/replay_receipt.json").read_text())
    for relative, expected in receipt["files"].items():
        actual = hashlib.sha256((ROOT / relative).read_bytes()).hexdigest()
        if actual != expected:
            raise AssertionError(f"hash mismatch: {relative}")


def validate_lean_evidence() -> None:
    evidence = json.loads(
        (ROOT / "data/lean_verification_20260718.json").read_text()
    )
    assert evidence["admitted"] is True
    assert evidence["command"] == "lake build"
    assert evidence["lean_toolchain"] == "leanprover/lean4:v4.28.0"
    assert evidence["mathlib_input_revision"] == "v4.28.0"
    assert (
        evidence["mathlib_resolved_commit"]
        == "8f9d9cff6bd728b17a24e163c9402775d9e6a365"
    )
    assert evidence["formalizes_full_sprague_grundy_replay"] is False
    assert evidence["output"] == "Build completed successfully (469 jobs)."


def run_crosscheck() -> dict[str, str]:
    compiler = shutil.which("clang++") or shutil.which("g++")
    if compiler is None:
        raise RuntimeError("a C++20 compiler is required")
    with tempfile.TemporaryDirectory(prefix="version-b-crosscheck-") as tmp:
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


def main() -> int:
    validate_receipt()
    validate_lean_evidence()
    mismatch, checked = first_python_mismatch()
    assert mismatch == TARGET
    assert checked == 127
    assert predicted_p(12, 7)
    assert not is_p(TARGET)
    assert is_p(ALL_OPTION)

    cross = run_crosscheck()
    expected = {
        "states": "646646",
        "eligible_positions_tested": "26286",
        "target_nimber": "2",
        "all_option_nimber": "0",
        "target_predicted_p": "1",
        "first_mismatch_piles": "12",
        "first_mismatch_odd": "7",
        "first_mismatch_counts": "5:7,6:5,",
    }
    assert cross == expected
    print(
        json.dumps(
            {
                "all_option_p": True,
                "cpp": expected,
                "python_first_mismatch_index": checked,
                "python_memoized_positions": is_p.cache_info().currsize,
                "source_prediction_p": True,
                "target_p": False,
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
