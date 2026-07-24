base = {0: 0, 1: 1, 2: 2, 3: 3, 4: 7}
tree_edges = [(0, 1), (0, 2), (0, 3), (3, 4)]
edges = {tuple(sorted(((base[u] + i) % 9, (base[v] + i) % 9))) for i in range(9) for u, v in tree_edges}
expected = {(i, j) for i in range(9) for j in range(i + 1, 9)}
assert len(edges) == 36 and edges == expected
print({"shifts": 9, "edges": 36, "status": "PASS"})
