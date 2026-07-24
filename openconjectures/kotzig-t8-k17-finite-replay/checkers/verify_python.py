labels = [0,8,7,6,1,5,2,4,3]
tree_edges = [(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8)]
assert len(set(labels)) == 9
lengths = {min(abs(labels[u]-labels[v]), 17-abs(labels[u]-labels[v])) for u,v in tree_edges}
assert lengths == set(range(1,9))
edges = {tuple(sorted(((labels[u]+i)%17,(labels[v]+i)%17))) for i in range(17) for u,v in tree_edges}
assert len(edges) == 136 and edges == {(i,j) for i in range(17) for j in range(i+1,17)}
print({"shifts": 17, "edges": 136, "status": "PASS"})
