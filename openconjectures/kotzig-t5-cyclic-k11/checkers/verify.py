from itertools import combinations
N = 11
TREE = [(0,1),(0,2),(0,3),(3,4),(4,5)]
BASE = {0:0,1:1,2:2,3:3,4:10,5:4}
def edge(a,b): return tuple(sorted((a % N,b % N)))
all_edges = set(combinations(range(N),2)); covered = set()
for i in range(N):
    current = {edge(BASE[u]+i, BASE[v]+i) for u,v in TREE}
    assert len(current) == 5 and covered.isdisjoint(current)
    covered |= current
assert covered == all_edges and len(covered) == 55
print('PASS: 11 cyclic shifts; 55 distinct edges; exact K11 coverage')
