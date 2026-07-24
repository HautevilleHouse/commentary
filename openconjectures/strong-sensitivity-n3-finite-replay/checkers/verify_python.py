from itertools import combinations
N=3; POINTS=range(1<<N); BLOCKS=range(1,1<<N)
def check(t):
    s=bs=0
    for x in POINTS:
        singles=sum(t[x^(1<<i)]!=t[x] for i in range(N)); s=max(s,singles)
        sens=[b for b in BLOCKS if t[x^b]!=t[x]]
        best=0
        for mask in range(1<<len(sens)):
            used=cnt=0
            for i,b in enumerate(sens):
                if mask>>i&1:
                    if used&b: break
                    used|=b; cnt+=1
            else: best=max(best,cnt)
        bs=max(bs,best)
    return bs,s
counts={}
for f in range(1<<8):
    t=[(f>>x)&1 for x in POINTS]; pair=check(t); assert pair[0]<=pair[1]**2
    counts[pair]=counts.get(pair,0)+1
assert counts=={(0,0):2,(1,1):6,(2,2):110,(3,3):138}
print(256,2,6,110,138)
