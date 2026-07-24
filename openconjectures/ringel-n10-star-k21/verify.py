from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 21 for j in range(11)) for c in range(21)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 11
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 210
assert set(edges) == set(combinations(range(21), 2))
print("PASS: twenty-one K1,10 copies partition E(K21)")
