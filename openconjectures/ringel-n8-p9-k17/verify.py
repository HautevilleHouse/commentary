from itertools import combinations

BASE = (0,8,1,7,2,6,3,5,4)
EMBEDDINGS = [tuple((x + c) % 17 for x in BASE) for c in range(17)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 9
    edges.extend(tuple(sorted((f[i], f[i + 1]))) for i in range(8))
assert len(edges) == len(set(edges)) == 136
assert set(edges) == set(combinations(range(17), 2))
print("PASS: seventeen P9 copies partition E(K17)")
