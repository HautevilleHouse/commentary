from itertools import combinations
N=27
TREE=[(0,1),(0,2),(0,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11),(11,12),(12,13)]
BASE={0:0,1:1,2:2,3:3,4:7,5:12,6:18,7:25,8:6,9:15,10:5,11:16,12:4,13:17}
def edge(a,b): return tuple(sorted((a%N,b%N)))
all_edges=set(combinations(range(N),2)); covered=set()
for i in range(N):
    current={edge(BASE[u]+i,BASE[v]+i) for u,v in TREE}
    assert len(current)==13 and covered.isdisjoint(current)
    covered |= current
assert covered==all_edges and len(covered)==351
print('PASS: 27 cyclic shifts; 351 distinct edges; exact K27 coverage')
