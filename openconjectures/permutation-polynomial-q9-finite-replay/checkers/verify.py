"""Separate exhaustive q=9 replay using table-driven GF(81) arithmetic."""
N = 81

def coeff(a): return (a % 3, (a//3)%3, (a//9)%3, (a//27)%3)
def enc(a): return a[0] + 3*a[1] + 9*a[2] + 27*a[3]

def product(a,b):
    z=[0]*7
    aa=coeff(a); bb=coeff(b)
    for i in range(4):
        for j in range(4): z[i+j]=(z[i+j]+aa[i]*bb[j])%3
    for d in range(6,3,-1):
        c=z[d]%3; z[d]=0
        z[d-3]=(z[d-3]+c)%3
        z[d-2]=(z[d-2]+2*c)%3
    return enc(z[:4])

M=[[product(a,b) for b in range(N)] for a in range(N)]
def power(a,n):
    r=1
    while n:
        if n&1: r=M[r][a]
        a=M[a][a]; n >>= 1
    return r
P=[[power(x,n) for x in range(N)] for n in (9,10)]
add=[[enc(tuple((u//(3**i)+v//(3**i))%3 for i in range(4))) for v in range(N)] for u in range(N)]

admissible=witnesses=0
for b in range(N):
    b9=P[0][b]
    for c in range(N):
        if b9 == c: continue
        admissible += N
        for d in range(N):
            seen=bytearray(N); ok=True
            for x in range(N):
                v=add[add[add[P[1][x]][M[b][P[0][x]]]][M[c][x]]][d]
                if seen[v]: ok=False; break
                seen[v]=1
            witnesses += ok
print(f"q=9 field_size=81 admissible_triples={admissible} permutation_witnesses={witnesses}")
