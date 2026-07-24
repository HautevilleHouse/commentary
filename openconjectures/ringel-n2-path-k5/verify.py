from itertools import combinations

EMBEDDINGS = [(0, 2, 1), (1, 3, 2), (2, 4, 3), (3, 0, 4), (4, 1, 0)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 3
    edges.extend((tuple(sorted((f[0], f[1]))), tuple(sorted((f[1], f[2])))))
assert len(edges) == len(set(edges)) == 10
assert set(edges) == set(combinations(range(5), 2))
print("PASS: five injective P3 copies partition E(K5)")
