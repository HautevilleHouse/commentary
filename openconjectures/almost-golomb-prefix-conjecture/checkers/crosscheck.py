#!/usr/bin/env python3
"""Cross-check by separately building both sequences from their runs."""

from __future__ import annotations

import json


LIMIT = 250_000


def golomb_from_self_describing_runs(limit: int) -> list[int]:
    g = [0, 1, 2, 2]
    value = 3
    while len(g) <= limit:
        run_length = g[value]
        g.extend([value] * run_length)
        value += 1
    return g[: limit + 1]


def full_memory_almost_prefix(limit: int) -> list[int]:
    # Before an order-r window truncates, the source identity says that the
    # run of m>=3 has length a(m+1).  This constructs that common prefix once.
    a = [0, 1, 2, 2, 2]
    value = 3
    while len(a) <= limit:
        run_length = a[value + 1]
        a.extend([value] * run_length)
        value += 1
    return a[: limit + 1]


def main() -> None:
    g = golomb_from_self_describing_runs(LIMIT)
    a = full_memory_almost_prefix(LIMIT)

    for n in range(3, LIMIT + 1):
        if a[n] != g[n - 1]:
            raise AssertionError((n, a[n], g[n - 1]))

    # separately check the one-position run-boundary displacement in one
    # linear pass.  The last, truncated run is excluded.
    g_bounds: dict[int, list[int]] = {}
    a_bounds: dict[int, list[int]] = {}
    for i in range(1, LIMIT):
        g_bounds.setdefault(g[i], [i, i])[1] = i
    for i in range(1, LIMIT + 1):
        a_bounds.setdefault(a[i], [i, i])[1] = i

    for value in range(3, g[LIMIT - 1]):
        g_start, g_end = g_bounds[value]
        a_start, a_end = a_bounds[value]
        if (a_start, a_end) != (g_start + 1, g_end + 1):
            raise AssertionError(
                {"value": value, "golomb": [g_start, g_end], "almost": [a_start, a_end]}
            )

    print(
        json.dumps(
            {
                "status": "PASS",
                "checked_indices": [3, LIMIT],
                "construction": "separate self-describing run builders",
                "universal_basis": "PROOF.md",
            },
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
