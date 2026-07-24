labels = [0, 1, 2, 3, 7, 12, 18, 11, 19, 5, 15, 4]
tree_edges = [(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11)]
assert len(set(labels)) == 12
lengths = {min(abs(labels[u]-labels[v]), 23-abs(labels[u]-labels[v])) for u,v in tree_edges}
assert lengths == set(range(1,12))
edges = {tuple(sorted(((labels[u]+i)%23,(labels[v]+i)%23))) for i in range(23) for u,v in tree_edges}
assert len(edges) == 253 and edges == {(i,j) for i in range(23) for j in range(i+1,23)}
print({"shifts": 23, "edges": 253, "status": "PASS"})
