# Almost Golomb Prefix Conjecture

This packet proves the **Prefix Conjecture** in Section 9.1 of
[Almost Golomb Sequences](https://arxiv.org/abs/2604.02404v1): for every
integer `r >= 3`, the almost Golomb sequence of order `r` satisfies

\[
a_r(r)=G(r-1),
\]

where `G` is Golomb's self-describing sequence.

## Result

The source's run theorem implies that, before the sliding window truncates,
the run of every value `m >= 3` has length `a_r(m+1)`.  The run of `2` in an
almost Golomb sequence has one additional term compared with Golomb's
sequence.  From value `3` onward, induction therefore gives runs of the same
length as Golomb's sequence, shifted one position to the right.  Hence
`a_r(n)=G(n-1)` for every `3 <= n <= r`, and the conjecture follows at `n=r`.

The complete argument is in [PROOF.md](PROOF.md).

## Replay

Run two separate exact constructions:

```bash
python3 checkers/verify.py
python3 checkers/crosscheck.py
```

Build the small Lean certificate for the interval-shift step:

```bash
cd lean
lake build
```

The computations corroborate the indexing and run recurrences.  The universal
result comes from the written proof, not from a finite search.

## Evidence boundary

- The closed object is the Prefix Conjecture `a_r(r)=G(r-1)`.
- The same proof yields the source's boundary identity
  `N_r(r-1)=G(r-1)` for `r >= 4`.
- The separate Domination Lemma `M(r)=N_r(r-1)` remains open.
- The paper's full threshold law for `j_k` (OpenConjecture 1688) therefore
  remains carried.
- The Lean file checks the run-interval shift used in the induction.  A full
  formalization of the source's infinite sequence construction remains
  outside this packet.
- External expert review remains pending.

The source paper and Golomb sequence references remain the work of their
respective authors.
