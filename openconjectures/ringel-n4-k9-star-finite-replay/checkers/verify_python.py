edges = [
    [(i, (i + d) % 9) for d in range(1, 5)] for i in range(9)
]
seen = [tuple(sorted(e)) for star in edges for e in star]
assert len(seen) == 36 and len(set(seen)) == 36
assert set(seen) == {(i, j) for i in range(9) for j in range(i + 1, 9)}
print({"stars": 9, "edges": 36, "status": "PASS"})
