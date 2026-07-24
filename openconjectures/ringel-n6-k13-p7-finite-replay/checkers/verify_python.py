base = [0, 1, 3, 6, 10, 2, 8]
paths = [[(i + x) % 13 for x in base] for i in range(13)]
edges = [tuple(sorted((p[j], p[j + 1]))) for p in paths for j in range(6)]
expected = {(i, j) for i in range(13) for j in range(i + 1, 13)}
assert all(len(set(p)) == 7 for p in paths)
assert len(edges) == 78 and len(set(edges)) == 78 and set(edges) == expected
print({"paths": 13, "edges": 78, "status": "PASS"})
