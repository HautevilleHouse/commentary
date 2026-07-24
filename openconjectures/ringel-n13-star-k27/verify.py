from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 27 for j in range(14)) for c in range(27)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 14
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 351
assert set(edges) == set(combinations(range(27), 2))
print("PASS: twenty-seven K1,13 copies partition E(K27)")
