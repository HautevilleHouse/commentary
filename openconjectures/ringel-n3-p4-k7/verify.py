from itertools import combinations

EMBEDDINGS = [(0, 1, 3, 6), (1, 2, 4, 0), (2, 3, 5, 1),
              (3, 4, 6, 2), (4, 5, 0, 3), (5, 6, 1, 4), (6, 0, 2, 5)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 4
    edges.extend(tuple(sorted((f[i], f[i + 1]))) for i in range(3))
assert len(edges) == len(set(edges)) == 21
assert set(edges) == set(combinations(range(7), 2))
print("PASS: seven P4 copies partition E(K7)")
