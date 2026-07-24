from itertools import combinations
N=25
TREE=[(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11),(11,12)]
BASE={0:0,1:11,2:13,3:1,4:24,5:2,6:23,7:3,8:22,9:4,10:21,11:5,12:20}
def edge(a,b): return tuple(sorted((a%N,b%N)))
all_edges=set(combinations(range(N),2)); covered=set()
for i in range(N):
    current={edge(BASE[u]+i,BASE[v]+i) for u,v in TREE}
    assert len(current)==12 and covered.isdisjoint(current)
    covered |= current
assert covered==all_edges and len(covered)==300
print('PASS: 25 cyclic shifts; 300 distinct edges; exact K25 coverage')
