labels = [0,9,8,10,3,18,13,17,20,1,2]
tree_edges = [(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10)]
assert len(set(labels)) == 11
lengths = {min(abs(labels[u]-labels[v]), 21-abs(labels[u]-labels[v])) for u,v in tree_edges}
assert lengths == set(range(1,11))
edges = {tuple(sorted(((labels[u]+i)%21,(labels[v]+i)%21))) for i in range(21) for u,v in tree_edges}
assert len(edges) == 210 and edges == {(i,j) for i in range(21) for j in range(i+1,21)}
print({"shifts": 21, "edges": 210, "status": "PASS"})
