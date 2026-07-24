# Stack-sortable permutations: n=11 finite replay

This packet checks the n=11 instance of the conjecture in
[arXiv:2604.10779v2](https://arxiv.org/abs/2604.10779), observed 2026-07-20.
It exhaustively enumerates all `11! = 39,916,800` permutations, applies the
source stack-sorting map twice, and counts those ending in their least entry.

Result: `|W'_2(11)| = 5798 = M_11`. This is a finite n=11 result only; the
all-n Motzkin conjecture remains open.

## Replay

```sh
c++ -O3 -std=c++17 checkers/verify.cpp -o /tmp/stack_n11 && /tmp/stack_n11
swiftc -O checkers/verify.swift -o /tmp/stack_n11_swift && /tmp/stack_n11_swift
```

Both implementations print `5798`.
