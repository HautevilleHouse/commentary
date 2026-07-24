from itertools import combinations

BASE = (0,9,10,18,1,8,11,17,2,7)
EMBEDDINGS = [tuple((x + c) % 19 for x in BASE) for c in range(19)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 10
    edges.extend(tuple(sorted((f[i], f[i + 1]))) for i in range(9))
assert len(edges) == len(set(edges)) == 171
assert set(edges) == set(combinations(range(19), 2))
print("PASS: nineteen P10 copies partition E(K19)")
