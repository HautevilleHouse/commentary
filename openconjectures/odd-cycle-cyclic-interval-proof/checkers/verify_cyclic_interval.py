#!/usr/bin/env python3
"""Verify the averaging inequalities and finite cyclic-interval instances."""

from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "data" / "cyclic_interval_check_20260717.json"


def arc_mask(m: int, start: int, length: int) -> int:
    mask = 0
    for offset in range(length):
        mask |= 1 << ((start + offset) % m)
    return mask


def normalized_subset(mask: int, m: int) -> int:
    full = (1 << m) - 1
    if mask.bit_count() > m // 2:
        return full ^ mask
    return mask


def find_witness(mask: int, m: int) -> tuple[int, int, int]:
    x = normalized_subset(mask, m)
    d = m // 2
    w = x.bit_count()
    length = d if w % 2 else d + 1
    target = min(length, m - length)
    for start in range(m):
        arc = arc_mask(m, start, length)
        difference = (arc ^ x).bit_count()
        if difference < target:
            return start, length, difference
    raise AssertionError(f"no witness for m={m}, mask={mask}")


def verify_averaging_grid(max_d: int = 1000) -> int:
    checked = 0
    for d in range(1, max_d + 1):
        m = 2 * d + 1
        for w in range(1, d + 1):
            if w % 2:
                # d*w/m > (w-1)/2, with numerator difference m-w.
                assert 2 * d * w > m * (w - 1)
                assert m - w > 0
            else:
                # (d+1)*w/m > w/2, with numerator difference w.
                assert 2 * (d + 1) * w > m * w
                assert w > 0
            checked += 1
    return checked


def verify_exhaustively(max_m: int = 19) -> tuple[int, dict[str, int]]:
    checked = 0
    by_order = {}
    for m in range(3, max_m + 1, 2):
        local = 0
        full = (1 << m) - 1
        for mask in range(1, full):
            start, length, difference = find_witness(mask, m)
            assert 0 <= start < m
            assert difference < min(length, m - length)
            local += 1
        by_order[str(m)] = local
        checked += local
    return checked, by_order


def main() -> None:
    inequality_cases = verify_averaging_grid()
    subsets_checked, by_order = verify_exhaustively()
    report = {
        "status": "pass",
        "claim": "cyclic interval lemma for odd cycles",
        "proof_parameter_cases_checked": inequality_cases,
        "proof_parameter_max_d": 1000,
        "exhaustive_max_odd_m": 19,
        "exhaustive_subsets_checked": subsets_checked,
        "exhaustive_subsets_by_order": by_order,
        "general_proof_basis": {
            "odd_w": "average over length-d arcs exceeds (w-1)/2",
            "even_w": "average over length-(d+1) arcs exceeds w/2",
            "note": "finite checks corroborate but do not supply the universal quantifier",
        },
    }
    OUTPUT.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    print(json.dumps(report, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
