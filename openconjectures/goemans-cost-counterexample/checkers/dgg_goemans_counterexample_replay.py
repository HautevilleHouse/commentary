#!/usr/bin/env python3
from itertools import product
demand={"t1":15,"t2":10,"t3":15}; dmax=15
edges={("s","t1"):(10,2),("s","t2"):(6,3),("s","u"):(24,0),("u","t3"):(10,2),("u","v"):(14,0),("v","t1"):(5,0),("v","w"):(9,0),("w","t2"):(4,0),("w","t3"):(5,0)}
paths={"t1":[(("s","t1"),),(("s","u"),("u","v"),("v","t1"))],"t2":[(("s","t2"),),(("s","u"),("u","v"),("v","w"),("w","t2"))],"t3":[(("s","u"),("u","t3")),(("s","u"),("u","v"),("v","w"),("w","t3"))]}
x={e:v[0] for e,v in edges.items()}; c={e:v[1] for e,v in edges.items()}
assert sum(x.values())==87 and x[("s","t1")]+x[("s","t2")]+x[("s","u")]==40
assert 10+5==15 and 6+4==10 and 10+5==15 and sum(x[e]*c[e] for e in edges)==58
rows=[]
for ch in product((0,1),repeat=3):
 load={e:0 for e in edges}; total=0
 for i,t in enumerate(("t1","t2","t3")):
  p=paths[t][ch[i]]; total+=demand[t]*sum(c[e] for e in p)
  for e in p: load[e]+=demand[t]
 bad={e:load[e]-x[e]-dmax for e in edges if load[e]>x[e]+dmax}
 rows.append((ch,total,not bad,bad))
assert len(rows)==8 and sum(r[2] for r in rows)==4 and all(r[1]>=60 for r in rows if r[2])
print("DGG/Goemans finite counterexample Python replay PASS")
for r in rows: print(r)
