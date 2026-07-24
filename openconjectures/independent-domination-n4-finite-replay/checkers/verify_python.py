from itertools import combinations
N=4; EDGES=list(combinations(range(N),2))
def ok(mask):
    adj=[[False]*N for _ in range(N)]
    for i,(u,v) in enumerate(EDGES):
        if mask>>i&1: adj[u][v]=adj[v][u]=True
    deg=[sum(r) for r in adj]
    if min(deg)==0:return None
    D=max(deg); best=N+1
    for s in range(1<<N):
        if s.bit_count()>=best:continue
        if any((s>>u&1 and s>>v&1 and adj[u][v]) for u,v in EDGES):continue
        if all(s>>v&1 or any(s>>u&1 and adj[u][v] for u in range(N)) for v in range(N)):
            best=s.bit_count()
    lhs=((D+2)**2*best if D%2==0 else (D+1)*(D+3)*best)
    rhs=((D*D+4)*N if D%2==0 else (D*D+3)*N)
    return D,best,lhs<=rhs
rows=[(m,ok(m)) for m in range(64) if ok(m) is not None]
bad=[m for m,r in rows if not r[2]]
assert len(rows)==41 and not bad
print(f"graphs={len(rows)} violating_masks={bad}")
