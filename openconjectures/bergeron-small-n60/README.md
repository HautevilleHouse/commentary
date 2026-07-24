# Bergeron Gaussian coefficient conjecture: exact finite bound `<=60`

This packet settles the following finite restriction of Bergeron's conjecture
from [arXiv:2607.04050v1](https://arxiv.org/abs/2607.04050v1): enumerate every
`1<=a<b<c<d<=60` with `ad=bc`, and verify coefficientwise that

```text
[b+c choose b]_q - [a+d choose a]_q >= 0.
```

The exhaustive result is **1,173 admissible quadruples**, **613,167 checked
coefficients**, and **zero negative coefficients**. The unrestricted
conjecture (with no bound of 60) remains open.

## Exact source boundary

The source target is the coefficientwise comparison under `1<=a<b<c<d` and
`ad=bc`, not unimodality of an individual Gaussian polynomial and not a
specialized value of `q`. The finite statement and recurrence are pinned in
`data/source_identity.json`.

## Separate replays

```bash
python3 openconjectures/bergeron-small-n60/checkers/verify.py
clang++ -std=c++17 -O2 -Wall -Wextra -pedantic \
  openconjectures/bergeron-small-n60/checkers/crosscheck.cpp \
  -o /tmp/bergeron_small_verify && /tmp/bergeron_small_verify
```

Both checkers implement the exact recurrence
`G(n,k)=G(n-1,k)+q^(n-k)G(n-1,k-1)` using separate integer arithmetic.
The Python route uses native arbitrary-precision integers; the C++ route uses
a separate base-`10^9` integer implementation. Both report `RESULT: PASS`.

## Rights

The source is cited by version and URL. This packet preserves the repository's
existing public rights notice and grants no additional permission.
