E=[(a,b) for a in range(3) for b in range(3)]
def add(x,y): return ((x[0]+y[0])%3,(x[1]+y[1])%3)
def mul(x,y): return ((x[0]*y[0]+2*x[1]*y[1])%3,(x[0]*y[1]+x[1]*y[0])%3)
def power(x,n):
    r=(1,0)
    for _ in range(n): r=mul(r,x)
    return r
permutations=0; admissible=0
for b in E:
    for c in E:
        if power(b,3)==c: continue
        for d in E:
            admissible+=1
            vals=[add(add(add(power(x,4),mul(b,power(x,3))),mul(c,x)),d) for x in E]
            if len(set(vals))==9: permutations+=1
assert (admissible, permutations)==(648,0)
print(admissible, permutations)
