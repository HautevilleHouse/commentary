from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 15 for j in range(8)) for c in range(15)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 8
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 105
assert set(edges) == set(combinations(range(15), 2))
print("PASS: fifteen K1,7 copies partition E(K15)")
