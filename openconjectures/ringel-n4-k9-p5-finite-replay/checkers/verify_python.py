base = [0, 2, 3, 6, 1]
paths = [[(i + x) % 9 for x in base] for i in range(9)]
edges = [tuple(sorted((p[j], p[j + 1]))) for p in paths for j in range(4)]
expected = {(i, j) for i in range(9) for j in range(i + 1, 9)}
assert all(len(set(p)) == 5 for p in paths)
assert len(edges) == 36 and len(set(edges)) == 36 and set(edges) == expected
print({"paths": 9, "edges": 36, "status": "PASS"})
