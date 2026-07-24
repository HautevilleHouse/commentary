from itertools import combinations
N=13
TREE=[(0,1),(0,2),(0,3),(3,4),(4,5),(5,6)]
BASE={0:2,1:3,2:4,3:5,4:1,5:6,6:0}
def edge(a,b): return tuple(sorted((a%N,b%N)))
all_edges=set(combinations(range(N),2)); covered=set()
for i in range(N):
    current={edge(BASE[u]+i,BASE[v]+i) for u,v in TREE}
    assert len(current)==6 and covered.isdisjoint(current)
    covered |= current
assert covered==all_edges and len(covered)==78
print('PASS: 13 cyclic shifts; 78 distinct edges; exact K13 coverage')
