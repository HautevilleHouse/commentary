# Does the refined exchange (per-gap undecorated counts) extend to area 2 (m = 0^{n-2} 1 1)?
# Test both granularities: diagonal-blind and per-diagonal undecorated counts.
from itertools import product, combinations
from collections import defaultdict
import sys

def gen_areas2(n):
    for ps in combinations(range(1, n), 2):     # positions of the two 1's (0-indexed, >=1)
        a = [0]*n
        for p in ps: a[p] = 1
        yield tuple(a)

def run(n, M):
    B = defaultdict(lambda: defaultdict(dict)); Dg = defaultdict(lambda: defaultdict(dict))
    for a in gen_areas2(n):
        rises = [i for i in range(n-1) if a[i+1] == a[i]+1]
        for w in product(range(1, M+1), repeat=n):
            if any(not (w[i] < w[i+1]) for i in rises): continue
            vall = [j for j in range(1, n) if a[j-1] > a[j] or (a[j-1]==a[j] and w[j-1]<w[j])]
            atk = [(i,j) for i in range(n) for j in range(i+1,n)
                   if (a[i]==a[j] and w[i]<w[j]) or (a[i]==a[j]+1 and w[i]>w[j])]
            for ssz in range(len(vall)+1):
                for S in combinations(vall, ssz):
                    Sset = set(S)
                    dinv = sum(1 for (i,j) in atk if i not in Sset) - len(S)
                    for r in range(1, M):
                        out = [j for j in range(n) if w[j] not in (r, r+1)]
                        Xi = tuple((a[j], w[j], j in Sset) for j in out)
                        al = sum(1 for j in range(n) if w[j]==r); be = sum(1 for j in range(n) if w[j]==r+1)
                        # gap index of each active: number of outside rows before it
                        outset = set(out)
                        gap = 0; cb = defaultdict(int); cd = defaultdict(int)
                        for j in range(n):
                            if j in outset: gap += 1
                            elif j not in Sset:
                                cb[gap] += 1; cd[(gap, a[j])] += 1
                        s = len(out)
                        vb = tuple(cb[t] for t in range(s+1))
                        vd = tuple((cd[(t,0)], cd[(t,1)]) for t in range(s+1))
                        key = (r, ssz, Xi)
                        for store, vec in ((B,(key,vb)), (Dg,(key,vd))):
                            P = store[vec[0]+ (vec[1],)][(al,be)]
                            P[dinv] = P.get(dinv,0) + 1
    out = {}
    for store, label in ((B,'diag-blind'), (Dg,'per-diagonal')):
        nb = 0
        for cls, d in store.items():
            if any(d.get((x,y),{}) != d.get((y,x),{}) for (x,y) in list(d)):
                nb += 1
                if nb <= 2: print('  ASYM', label, 'class:', cls)
        nt = len(store)
        print(f"n={n} M={M} [{label}]: refined classes={nt}, asymmetric={nb}")
        sys.stdout.flush()
        out[label] = (nt, nb, set(store))
    return out

CASES = {'quick': [(4, 4), (5, 4)],
         'full':  [(4, 4), (5, 4), (5, 5), (6, 4)]}

if __name__ == '__main__':
    mode = sys.argv[1] if len(sys.argv) > 1 else 'quick'
    if mode not in CASES:
        print('usage: python3 area2.py [quick|full]'); sys.exit(2)
    if mode == 'quick':
        print('mode=quick: ranges (4,4),(5,4) only.  Run')
        print("  python3 area2.py full")
        print('to reproduce all four ranges of Section 8.2 (40,143 per-diagonal')
        print('class checks; 37,027 distinct classes; substantially longer runtime).')
    totals = {'diag-blind': [0, 0, set()], 'per-diagonal': [0, 0, set()]}
    for (n, M) in CASES[mode]:
        res = run(n, M)
        for lab, (nt, nb, keys) in res.items():
            totals[lab][0] += nt; totals[lab][1] += nb; totals[lab][2].update(keys)
    for lab, (nt, nb, keys) in totals.items():
        print(f"TOTAL [{lab}]: refined classes={nt}, distinct={len(keys)}, asymmetric={nb}")
    ok = all(nb == 0 for (_, nb, _) in totals.values())
    print('RESULT:', 'PASS' if ok else 'FAIL')
    sys.exit(0 if ok else 1)
