from itertools import combinations

EMBEDDINGS = [tuple((c + j) % 17 for j in range(9)) for c in range(17)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 9
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 136
assert set(edges) == set(combinations(range(17), 2))
print("PASS: seventeen K1,8 copies partition E(K17)")
