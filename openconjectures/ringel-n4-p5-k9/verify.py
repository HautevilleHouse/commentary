from itertools import combinations

EMBEDDINGS = [(0, 1, 3, 6, 2), (1, 2, 4, 7, 3), (2, 3, 5, 8, 4),
              (3, 4, 6, 0, 5), (4, 5, 7, 1, 6), (5, 6, 8, 2, 7),
              (6, 7, 0, 3, 8), (7, 8, 1, 4, 0), (8, 0, 2, 5, 1)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 5
    edges.extend(tuple(sorted((f[i], f[i + 1]))) for i in range(4))
assert len(edges) == len(set(edges)) == 36
assert set(edges) == set(combinations(range(9), 2))
print("PASS: nine P5 copies partition E(K9)")
