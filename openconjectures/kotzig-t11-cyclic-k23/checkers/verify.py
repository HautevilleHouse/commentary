from itertools import combinations
N=23
TREE=[(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11)]
BASE={0:11,1:20,2:21,3:0,4:1,5:3,6:6,7:10,8:15,9:9,10:16,11:8}
def edge(a,b): return tuple(sorted((a%N,b%N)))
all_edges=set(combinations(range(N),2)); covered=set()
for i in range(N):
    current={edge(BASE[u]+i,BASE[v]+i) for u,v in TREE}
    assert len(current)==11 and covered.isdisjoint(current)
    covered |= current
assert covered==all_edges and len(covered)==253
print('PASS: 23 cyclic shifts; 253 distinct edges; exact K23 coverage')
