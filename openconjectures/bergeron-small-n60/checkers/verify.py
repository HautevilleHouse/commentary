#!/usr/bin/env python3
"""Exact finite replay of Bergeron's conjecture for a,b,c,d <= 60."""

MAX_SUM = 120


def build_qbinom(max_n):
    table = [[None] * (n + 1) for n in range(max_n + 1)]
    table[0][0] = [1]
    for n in range(1, max_n + 1):
        table[n][0] = [1]
        table[n][n] = [1]
        for k in range(1, n):
            left = table[n - 1][k]
            right = table[n - 1][k - 1]
            out = [0] * max(len(left), len(right) + n - k)
            for i, value in enumerate(left):
                out[i] += value
            for i, value in enumerate(right):
                out[i + n - k] += value
            table[n][k] = out
    return table


def main():
    qbinom = build_qbinom(MAX_SUM)
    quadruples = 0
    checked_coefficients = 0
    for a in range(1, 61):
        for b in range(a + 1, 61):
            for c in range(b + 1, 61):
                if (b * c) % a:
                    continue
                d = (b * c) // a
                if not (c < d <= 60):
                    continue
                quadruples += 1
                lhs = qbinom[b + c][b]
                rhs = qbinom[a + d][a]
                for i in range(max(len(lhs), len(rhs))):
                    lv = lhs[i] if i < len(lhs) else 0
                    rv = rhs[i] if i < len(rhs) else 0
                    checked_coefficients += 1
                    assert lv >= rv, (a, b, c, d, i, lv, rv)
    print(f"quadruples={quadruples}; coefficients_checked={checked_coefficients}; negative_coefficients=0")
    print("RESULT: PASS")


if __name__ == "__main__":
    main()
