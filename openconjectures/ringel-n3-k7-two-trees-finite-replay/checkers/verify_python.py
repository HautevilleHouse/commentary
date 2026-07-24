expected = {(i, j) for i in range(7) for j in range(i + 1, 7)}
paths = [[i % 7, (i + 1) % 7, (i + 3) % 7, (i + 6) % 7] for i in range(7)]
stars = [[i, (i + 1) % 7, (i + 2) % 7, (i + 3) % 7] for i in range(7)]
def edges(rows):
    return {tuple(sorted((r[j], r[j + 1]))) for r in rows for j in range(len(r) - 1)}
def star_edges(rows):
    return {tuple(sorted((r[0], x))) for r in rows for x in r[1:]}
assert edges(paths) == expected and len(edges(paths)) == 21
assert star_edges(stars) == expected and len(star_edges(stars)) == 21
print({"trees": 2, "edges_each": 21, "status": "PASS"})
