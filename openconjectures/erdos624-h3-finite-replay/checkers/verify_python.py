from itertools import combinations,product
X=range(3); S=[frozenset(c) for n in range(4) for c in combinations(X,n)]; cand=(0,1,2,2,0,0,1,0)
def works(v,t):
 d=dict(zip(S,v))
 return all({d[a] for a in S if a<=frozenset(c)}==set(X) for n in range(t,4) for c in combinations(X,n))
assert works(cand,2) and not works(cand,1)
counts=[sum(works(v,t) for v in product(X,repeat=8)) for t in range(3)]
assert counts==[0,0,720];print('H(3)=2; functions=6561; m0=0; m1=0; m2=720')
