from itertools import combinations

N = 9
TREE = [(0, 1), (0, 2), (0, 3), (3, 4)]
BASE = {0: 0, 1: 1, 2: 2, 3: 3, 4: 7}

def edge(a, b):
    a, b = a % N, b % N
    return tuple(sorted((a, b)))

all_edges = set(combinations(range(N), 2))
shifted = set()
for i in range(N):
    current = {edge(BASE[u] + i, BASE[v] + i) for u, v in TREE}
    assert len(current) == 4
    assert shifted.isdisjoint(current)
    shifted |= current
assert len(shifted) == 36 and shifted == all_edges
print('PASS: 9 cyclic shifts; 36 distinct edges; exact K9 coverage')
