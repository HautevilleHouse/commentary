#!/usr/bin/env python3
"""Separate finite replay of the Almost Golomb prefix proof.

This script constructs each order-r prefix from the source run-length identity
and constructs Golomb's sequence with the Mallows recurrence.  The finite
check corroborates the proof; it is not the basis of the universal claim.
"""

from __future__ import annotations

import json


MAX_ORDER = 5000


def golomb_mallows(limit: int) -> list[int]:
    g = [0] * (limit + 1)
    g[1] = 1
    for n in range(1, limit):
        g[n + 1] = 1 + g[n + 1 - g[g[n]]]
    return g


def almost_prefix_from_run_identity(order: int) -> list[int]:
    if order < 3:
        raise ValueError("the Prefix Conjecture starts at order 3")

    # The source initial-prefix theorem fixes positions 1 through 4.
    a = [0, 1, 2, 2, 2]
    value = 3
    while len(a) <= order:
        left = value + 1 - order
        previous = a[left] if left > 0 else 0
        run_length = a[value + 1] - previous
        if run_length <= 0:
            raise AssertionError((order, value, run_length))
        a.extend([value] * run_length)
        value += 1
    return a[: order + 1]


def main() -> None:
    g = golomb_mallows(MAX_ORDER)
    checked_terms = 0
    for order in range(3, MAX_ORDER + 1):
        a = almost_prefix_from_run_identity(order)
        for n in range(3, order + 1):
            if a[n] != g[n - 1]:
                raise AssertionError(
                    {"order": order, "index": n, "almost": a[n], "golomb": g[n - 1]}
                )
            checked_terms += 1

    print(
        json.dumps(
            {
                "status": "PASS",
                "orders": [3, MAX_ORDER],
                "checked_prefix_terms": checked_terms,
                "claim": "finite corroboration of a_r(n)=G(n-1) for 3<=n<=r",
                "universal_basis": "PROOF.md",
            },
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
