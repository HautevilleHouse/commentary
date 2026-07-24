from itertools import combinations

STARS = [(0, 1, 2, 3, 4), (1, 2, 3, 4, 5), (2, 3, 4, 5, 6),
         (3, 4, 5, 6, 7), (4, 5, 6, 7, 8), (5, 6, 7, 8, 0),
         (6, 7, 8, 0, 1), (7, 8, 0, 1, 2), (8, 0, 1, 2, 3)]
edges = []
for s in STARS:
    assert len(set(s)) == 5
    edges.extend(tuple(sorted((s[0], leaf))) for leaf in s[1:])
assert len(edges) == len(set(edges)) == 36
assert set(edges) == set(combinations(range(9), 2))
print("PASS: nine K1,4 copies partition E(K9)")
