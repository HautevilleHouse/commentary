from itertools import permutations
from collections import Counter
from math import comb

N = 6

def avoids312(p):
    for i in range(N):
        for j in range(i + 1, N):
            for k in range(j + 1, N):
                if p[i] > p[k] > p[j]:
                    return False
    return True

def inv(p):
    return sum(p[i] > p[j] for i in range(N) for j in range(i + 1, N))

def add(a, b):
    c = Counter(a)
    c.update(b)
    return +c

def shift(a, dq, dp):
    return Counter({(q + dq, p + dp): v for (q, p), v in a.items()})

perms = [p for p in permutations(range(1, N + 1)) if avoids312(p)]
rhs = []
for k in range(N + 1):
    c = Counter()
    for p in perms:
        if p.index(N) <= k:
            q = inv(p)
            c[(q, comb(N, 2) - q)] += 1
    rhs.append(c)
lhs = [[Counter() for _ in range(N + 1)] for _ in range(N + 1)]
lhs[0][0][(0, 0)] = 1
for n in range(1, N + 1):
    lhs[n][0][(comb(n, 2), 0)] = 1
    for k in range(1, n + 1):
        lhs[n][k] = add(lhs[n][k - 1], shift(lhs[n - 1][k], n - k - 1, k))
mismatches = [k for k in range(N + 1) if lhs[N][k] != rhs[k]]
assert len(perms) == 132 and not mismatches
print({'n': N, '312_avoiding': len(perms), 'mismatches': mismatches,
       'lhs': [dict(sorted(x.items())) for x in lhs[N]],
       'rhs': [dict(sorted(x.items())) for x in rhs]})
