from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 19 for j in range(10)) for c in range(19)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 10
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 171
assert set(edges) == set(combinations(range(19), 2))
print("PASS: nineteen K1,9 copies partition E(K19)")
