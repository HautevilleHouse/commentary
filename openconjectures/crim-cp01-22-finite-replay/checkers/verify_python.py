def mex(values):
    i = 0
    while i in values:
        i += 1
    return i
states = {(): (), (2,): ((),), (2,2): ((2,),)}
g, h = {(): 0}, {(): 1}
for p in [(2,), (2,2)]:
    opts = states[p]
    g[p] = mex({g[o] for o in opts})
    h[p] = mex({h[o] for o in opts})
assert (g[(2,2)], h[(2,2)]) == (0,1)
print({"state": [2,2], "pair": [0,1], "status": "PASS"})
