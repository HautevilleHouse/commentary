from itertools import combinations

EMBEDDINGS = [(0,1,2,3,4,5,6), (1,2,3,4,5,6,7), (2,3,4,5,6,7,8),
              (3,4,5,6,7,8,9), (4,5,6,7,8,9,10), (5,6,7,8,9,10,11),
              (6,7,8,9,10,11,12), (7,8,9,10,11,12,0), (8,9,10,11,12,0,1),
              (9,10,11,12,0,1,2), (10,11,12,0,1,2,3), (11,12,0,1,2,3,4),
              (12,0,1,2,3,4,5)]
edges = []
for c, *leaves in EMBEDDINGS:
    assert len({c, *leaves}) == 7
    edges.extend(tuple(sorted((c, x))) for x in leaves)
assert len(edges) == len(set(edges)) == 78
assert set(edges) == set(combinations(range(13), 2))
print("PASS: thirteen K1,6 copies partition E(K13)")
