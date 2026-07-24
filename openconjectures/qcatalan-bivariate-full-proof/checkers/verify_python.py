#!/usr/bin/env python3
"""Self-contained finite replay of the q-Catalan insertion obligations."""
from itertools import permutations

N = 9

def avoids(p):
    return all(not (p[i] > p[k] > p[j])
               for i in range(len(p)) for j in range(i + 1, len(p))
               for k in range(j + 1, len(p)))

def inv(p):
    return sum(p[i] > p[j] for i in range(len(p)) for j in range(i + 1, len(p)))

for n in range(1, N + 1):
    prev = [()] if n == 1 else [p for p in permutations(range(1, n)) if avoids(p)]
    for k in range(n):
        domain = [p for p in prev if n == 1 or p.index(n - 1) <= k]
        image = []
        for p in domain:
            z = p[:k] + (n,) + p[k:]
            assert avoids(z) and z.index(n) == k
            assert inv(z) - inv(p) == n - k - 1
            assert ((n * (n - 1) // 2 - inv(z)) -
                    ((n - 1) * (n - 2) // 2 - inv(p))) == k
            image.append(z)
        target = [p for p in permutations(range(1, n + 1))
                  if avoids(p) and p.index(n) == k]
        assert set(image) == set(target), (n, k)
    prev = [p for p in permutations(range(1, n + 1)) if avoids(p)]
    assert set(prev) == {p for p in prev if p.index(n) <= n - 1}
print({"max_n": N, "status": "PASS"})
