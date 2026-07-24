# Exact m=3 misère quotient for the escalation game

This packet settles the `m=3` instance of Conjecture C(2) in
[arXiv:2606.29015v1](https://arxiv.org/abs/2606.29015v1), *Impartial
Combinatorial Games and the Nuclear Escalation Ladder*.

For the source's one-heap subtraction game with move set `{1,2,3}` and
misère rule that moving to zero loses, the exact misère quotient has five
elements:

```text
M = {1,e,x,y,z}
e^2=e,  x^2=y^2=z^2=e,  xy=z, xz=y, yz=x
```

`1` is the global identity, `{e,x,y,z}` is a Klein four-group with local
identity `e`, and the loss set is `{e}`. A heap `r` maps to `e,x,y,z` for
`r mod 4` equal to `1,2,3,0`, respectively. The proof that this is the exact
interchangeability quotient is in [PROOF.md](PROOF.md).

This settles only `m=3` for the exact contiguous move set `{1,2,3}`. The
source's all-`m` finiteness conjecture, non-contiguous move sets, and
three-player extension remain open.

## Pinned source

Observed 2026-07-19:

```text
e-print 10e9a174588e458fd56dc6bd3197656e3652291748269b2e507843c4476b9a5e
HTML    98af82e0e6906fb92dc19185d05de034bea3d10b696e6b02a8f5e411745627ac
PDF     cf9b692a3465b52c9ea19f1eb355fc838ee7a14a4cdfca6d246003c8d1022e46
```

The exact source boundary is Definition 2.1, Conjecture C(2) (`conj:C`),
Theorem `misere2`, and Remark `open`.

## Replays

```bash
python3 openconjectures/misere-escalation-m3-quotient/checkers/verify.py
clang++ -std=c++17 -O2 -Wall -Wextra -pedantic \
  openconjectures/misere-escalation-m3-quotient/checkers/crosscheck.cpp \
  -o /tmp/misere_escalation_m3_verify && /tmp/misere_escalation_m3_verify
```

Both routes check associativity, the source misère recursion, all multisets of
up to six heaps with heap sizes at most 30 (1,947,792 positions), and separation
of all five quotient classes. Both report `RESULT: PASS`.

## Rights

The source is cited by version and URL. The source record is CC BY 4.0; this
packet preserves the repository's existing public rights notice and grants no
additional permission.
