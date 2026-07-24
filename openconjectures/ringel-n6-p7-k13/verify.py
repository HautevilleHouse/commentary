from itertools import combinations

EMBEDDINGS = [(0,6,1,5,2,4,3), (1,7,2,6,3,5,4), (2,8,3,7,4,6,5),
              (3,9,4,8,5,7,6), (4,10,5,9,6,8,7), (5,11,6,10,7,9,8),
              (6,12,7,11,8,10,9), (7,0,8,12,9,11,10), (8,1,9,0,10,12,11),
              (9,2,10,1,11,0,12), (10,3,11,2,12,1,0), (11,4,12,3,0,2,1),
              (12,5,0,4,1,3,2)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 7
    edges.extend(tuple(sorted((f[i], f[i + 1]))) for i in range(6))
assert len(edges) == len(set(edges)) == 78
assert set(edges) == set(combinations(range(13), 2))
print("PASS: thirteen P7 copies partition E(K13)")
