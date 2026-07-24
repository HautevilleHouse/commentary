from itertools import combinations
N=21
TREE=[(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10)]
BASE={0:0,1:9,2:10,3:8,4:1,5:7,6:2,7:6,8:3,9:5,10:4}
def edge(a,b): return tuple(sorted((a%N,b%N)))
all_edges=set(combinations(range(N),2)); covered=set()
for i in range(N):
    current={edge(BASE[u]+i,BASE[v]+i) for u,v in TREE}
    assert len(current)==10 and covered.isdisjoint(current)
    covered |= current
assert covered==all_edges and len(covered)==210
print('PASS: 21 cyclic shifts; 210 distinct edges; exact K21 coverage')
