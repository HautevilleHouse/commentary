from __future__ import annotations
from collections import Counter
from itertools import combinations, permutations

PAIRS = {
    # source table classes 54, 69, 71; tau=12 and 0-based boxes
    "class54": (
        frozenset({(0,0),(0,1),(1,1),(2,0),(2,2)}),
        frozenset({(0,1),(0,2),(1,1),(2,0),(2,2)})),
    "class69": (
        frozenset({(0,1),(1,1),(1,2),(2,0)}),
        frozenset({(0,1),(1,0),(1,1),(2,2)})),
    "class71": (
        frozenset({(0,0),(0,1),(1,2),(2,0)}),
        frozenset({(0,0),(0,1),(1,0),(2,2)})),
}

def count(p, shaded):
    n = len(p); total = 0
    for i, j in combinations(range(n), 2):
        if not (p[i] < p[j]): continue
        lo, hi = p[i], p[j]
        for pos, val in enumerate(p):
            if pos in (i,j): continue
            c = 0 if pos < i else 1 if pos < j else 2
            r = 0 if val < lo else 1 if val < hi else 2
            if (r,c) in shaded: break
        else: total += 1
    return total

def main():
    for name, (a,b) in PAIRS.items():
        print(name, flush=True)
        for n in range(1, 10):
            ha, hb = Counter(), Counter()
            for p in permutations(range(1,n+1)):
                ha[count(p,a)] += 1; hb[count(p,b)] += 1
            print(f" n={n} equal={ha==hb} distinct={len(ha)}", flush=True)
            if ha != hb:
                print(" counterexample_histograms", sorted(ha.items()), sorted(hb.items()))
                break

if __name__ == '__main__': main()
