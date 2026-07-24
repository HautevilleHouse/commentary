paths = [[(i + x) % 11 for x in [0, 5, 1, 4, 2, 3]] for i in range(11)]
edges = [tuple(sorted((p[j], p[j + 1]))) for p in paths for j in range(5)]
expected = {(i, j) for i in range(11) for j in range(i + 1, 11)}
assert len(edges) == 55 and len(set(edges)) == 55 and set(edges) == expected
assert all(len(set(p)) == 6 for p in paths)
print({"paths": 11, "edges": 55, "status": "PASS"})
