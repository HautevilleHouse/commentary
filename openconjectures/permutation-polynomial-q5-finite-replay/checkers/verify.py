P=5; E=[(a,b) for a in range(P) for b in range(P)]
def add(x,y): return ((x[0]+y[0])%P,(x[1]+y[1])%P)
def mul(x,y): return ((x[0]*y[0]+2*x[1]*y[1])%P,(x[0]*y[1]+x[1]*y[0])%P)
def pw(x,n):
    r=(1,0)
    for _ in range(n): r=mul(r,x)
    return r
ad=bad=0
for b in E:
    for c in E:
        if pw(b,5)==c: continue
        for d in E:
            ad+=1
            out=[add(add(add(pw(x,6),mul(b,pw(x,5))),mul(c,x)),d) for x in E]
            bad+=len(set(out))==25
assert ad==15000 and bad==0
print(ad,bad)
