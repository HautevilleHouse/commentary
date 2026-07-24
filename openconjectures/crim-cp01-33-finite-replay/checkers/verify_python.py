#!/usr/bin/env python3
from functools import lru_cache

def mex(values):
    s = set(values); n = 0
    while n in s: n += 1
    return n

@lru_cache(None)
def options(p):
    return tuple(tuple(sorted(p[:i] + p[i+1:], reverse=True)) for i in range(len(p)))

@lru_cache(None)
def g(p): return mex(g(q) for q in options(p)) if p else 0

@lru_cache(None)
def h(p): return mex(h(q) for q in options(p)) if p else 1

assert options((3, 3)) == ((3,), (3,))
assert g(()) == 0 and h(()) == 1
assert (g((3,)), h((3,))) == (1, 0)
assert (g((3, 3)), h((3, 3))) == (0, 1)
print("CRIM [3,3]: pair=(0,1); states=[3,3]->[3]->[]")
