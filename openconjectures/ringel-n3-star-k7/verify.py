from itertools import combinations

STARS = [(0, 1, 2, 4), (1, 2, 3, 5), (2, 3, 4, 6),
         (3, 4, 5, 0), (4, 5, 6, 1), (5, 6, 0, 2), (6, 0, 1, 3)]
edges = []
for s in STARS:
    assert len(set(s)) == 4
    edges.extend(tuple(sorted((s[0], leaf))) for leaf in s[1:])
assert len(edges) == len(set(edges)) == 21
assert set(edges) == set(combinations(range(7), 2))
print("PASS: seven K1,3 copies partition E(K7)")
