from itertools import combinations

N = 4
BLOCKS = tuple(m for m in range(1, 1 << N))
DP = [0] * (1 << len(BLOCKS))
for cm in range(1, len(DP)):
    bit = cm & -cm; i = bit.bit_length()-1; rest = cm ^ bit
    blocked = 0
    for j,b in enumerate(BLOCKS):
        if BLOCKS[i] & b: blocked |= 1 << j
    DP[cm] = max(DP[rest], 1 + DP[rest & ~blocked])
def flip(x, b): return x ^ b

def measures(table):
    max_s = max_b = 0
    for x in range(1 << N):
        changing = [b for b in BLOCKS if table[x] != table[flip(x,b)]]
        s = sum(1 for b in changing if b & (b-1) == 0)
        max_s = max(max_s, s)
        cm = sum(1 << i for i,b in enumerate(BLOCKS) if b in changing)
        best = DP[cm]
        max_b = max(max_b, best)
    return max_s, max_b

def main():
    counts = {}; worst = (0,0)
    for code in range(1 << (1 << N)):
        table = [(code >> i) & 1 for i in range(1 << N)]
        s,b = measures(table)
        counts[(s,b)] = counts.get((s,b),0)+1
        if b > s*s: raise AssertionError((code,s,b))
        worst = max(worst,(s,b))
    print('functions=65536 inequality=PASS')
    print('max_sensitivity=%d max_block_sensitivity=%d' % worst)
    print('distribution=%s' % sorted(counts.items()))

if __name__ == '__main__': main()
