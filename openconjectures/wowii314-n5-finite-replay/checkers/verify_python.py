from itertools import combinations

def adj(mask, es, i, j):
    if i > j: i, j = j, i
    return bool(mask & (1 << es.index((i, j))))
def connected(mask, n, es):
    seen, stack = {0}, [0]
    while stack:
        v = stack.pop()
        for w in range(n):
            if w not in seen and adj(mask, es, v, w): seen.add(w); stack.append(w)
    return len(seen) == n
def triangle_free(mask, n, es):
    return not any(adj(mask, es, a, b) and adj(mask, es, b, c) and adj(mask, es, a, c)
                   for a, b, c in combinations(range(n), 3))
def total(mask, n, es, S):
    return all(any(v != w and w in S and adj(mask, es, v, w) for w in range(n)) for v in range(n))
def path_size(mask, n, es):
    best = 0
    for r in range(1, n + 1):
        for S in combinations(range(n), r):
            E = [(a, b) for a, b in combinations(S, 2) if adj(mask, es, a, b)]
            if len(E) != r - 1: continue
            deg = {v: 0 for v in S}
            for a, b in E: deg[a] += 1; deg[b] += 1
            if max(deg.values(), default=0) > 2: continue
            seen, stack = {S[0]}, [S[0]]
            while stack:
                v = stack.pop()
                for w in S:
                    if w not in seen and (min(v, w), max(v, w)) in E: seen.add(w); stack.append(w)
            if len(seen) == r: best = max(best, r)
    return best
def run():
    counts = {}; bad = 0
    for n in range(2, 6):
        es = list(combinations(range(n), 2)); retained = 0
        for mask in range(1 << len(es)):
            if not connected(mask, n, es) or not triangle_free(mask, n, es) or path_size(mask, n, es) > 4: continue
            retained += 1; sizes = set()
            for r in range(1, n + 1):
                for S0 in combinations(range(n), r):
                    S = set(S0)
                    if total(mask, n, es, S) and all(not total(mask, n, es, S - {x}) for x in S): sizes.add(r)
            if len(sizes) > 1: bad += 1
        counts[n] = retained
    assert counts == {2: 1, 3: 3, 4: 19, 5: 147} and bad == 0
    print(f"counts={counts} violations={bad}")
if __name__ == '__main__': run()
