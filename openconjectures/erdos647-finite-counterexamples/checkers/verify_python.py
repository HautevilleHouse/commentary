def divisors(m): return [d for d in range(1,m+1) if m%d==0]
cases={25:(24,27),26:(24,28),30:(28,32)}
for n,(w,bound) in cases.items():
    bad=[]
    for m in range(n):
        ds=divisors(m) if m else []
        if m+len(ds)>bound: bad.append((m,ds,len(ds),m+len(ds)))
    assert bad==[(w,divisors(w),len(divisors(w)),w+len(divisors(w)))]
    print(n,bad[0][0],bad[0][2],bad[0][3],bound)
