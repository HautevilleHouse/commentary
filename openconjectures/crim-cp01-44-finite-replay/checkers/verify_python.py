#!/usr/bin/env python3
from functools import lru_cache
def mex(v):
    s=set(v); n=0
    while n in s: n+=1
    return n
@lru_cache(None)
def opts(p): return tuple(tuple(sorted(p[:i]+p[i+1:],reverse=True)) for i in range(len(p)))
@lru_cache(None)
def g(p): return mex(g(q) for q in opts(p)) if p else 0
@lru_cache(None)
def h(p): return mex(h(q) for q in opts(p)) if p else 1
assert opts((4,4)) == ((4,),(4,))
assert (g(()), h(())) == (0,1)
assert (g((4,)),h((4,))) == (1,0)
assert (g((4,4)),h((4,4))) == (0,1)
print("CRIM [4,4]: pair=(0,1); states=[4,4]->[4]->[]")
