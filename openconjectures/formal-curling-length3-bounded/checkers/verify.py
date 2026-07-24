from itertools import product

def k(s):
    best = 1
    for l in range(1, len(s) + 1):
        block = s[-l:]
        q = 0
        while (q + 1) * l <= len(s) and s[-(q + 1) * l:len(s) - q * l if q else None] == block:
            q += 1
        best = max(best, q)
    return best

def hit(s):
    t, steps = list(s), 0
    while k(tuple(t)) != 1:
        t.append(k(tuple(t)))
        steps += 1
    return steps

cases = [s for n in range(1, 4) for s in product((-1, 0, 1), repeat=n)]
hist = {}
for s in cases:
    hist[hit(s)] = hist.get(hit(s), 0) + 1
assert len(cases) == 39 and hist == {0: 27, 1: 12}
print('PASS: 39 cases; histogram {0: 27, 1: 12}; maximum additional step 1')
