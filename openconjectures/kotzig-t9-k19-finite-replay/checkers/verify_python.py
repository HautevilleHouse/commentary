labels = [0,1,2,3,18,13,7,14,6,15]
tree_edges = [(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9)]
assert len(set(labels)) == 10
lengths = {min(abs(labels[u]-labels[v]), 19-abs(labels[u]-labels[v])) for u,v in tree_edges}
assert lengths == set(range(1,10))
edges = {tuple(sorted(((labels[u]+i)%19,(labels[v]+i)%19))) for i in range(19) for u,v in tree_edges}
assert len(edges) == 171 and edges == {(i,j) for i in range(19) for j in range(i+1,19)}
print({"shifts": 19, "edges": 171, "status": "PASS"})
