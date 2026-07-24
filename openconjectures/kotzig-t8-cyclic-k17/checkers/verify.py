from itertools import combinations
N=17
TREE=[(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8)]
BASE={0:0,1:1,2:2,3:3,4:7,5:12,6:6,7:13,8:4}
def edge(a,b): return tuple(sorted((a%N,b%N)))
all_edges=set(combinations(range(N),2)); covered=set()
for i in range(N):
    current={edge(BASE[u]+i,BASE[v]+i) for u,v in TREE}
    assert len(current)==8 and covered.isdisjoint(current)
    covered |= current
assert covered==all_edges and len(covered)==136
print('PASS: 17 cyclic shifts; 136 distinct edges; exact K17 coverage')
