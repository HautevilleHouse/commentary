from itertools import combinations

EMBEDDINGS = [(0,5,1,4,2,3), (1,6,2,5,3,4), (2,7,3,6,4,5),
              (3,8,4,7,5,6), (4,9,5,8,6,7), (5,10,6,9,7,8),
              (6,0,7,10,8,9), (7,1,8,0,9,10), (8,2,9,1,10,0),
              (9,3,10,2,0,1), (10,4,0,3,1,2)]
edges = []
for f in EMBEDDINGS:
    assert len(set(f)) == 6
    edges.extend(tuple(sorted((f[i], f[i + 1]))) for i in range(5))
assert len(edges) == len(set(edges)) == 55
assert set(edges) == set(combinations(range(11), 2))
print("PASS: eleven P6 copies partition E(K11)")
