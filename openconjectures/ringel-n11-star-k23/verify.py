from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 23 for j in range(12)) for c in range(23)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 12
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 253
assert set(edges) == set(combinations(range(23), 2))
print("PASS: twenty-three K1,11 copies partition E(K23)")
