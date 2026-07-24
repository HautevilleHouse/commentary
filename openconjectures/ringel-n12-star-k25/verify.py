from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 25 for j in range(13)) for c in range(25)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 13
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 300
assert set(edges) == set(combinations(range(25), 2))
print("PASS: twenty-five K1,12 copies partition E(K25)")
