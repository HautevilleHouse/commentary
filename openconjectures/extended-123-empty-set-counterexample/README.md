# Extended 1-2-3 Displayed-Statement Counterexample

Source paper: Philippa Holdridge and Péter Pál Pach,
[On the Extended 1-2-3 Conjecture of Pilz](https://arxiv.org/abs/2607.00934v1).

Source object: OpenConjecture `4736`, arXiv:`2607.00934v1`, the displayed
conjecture in `final_version.tex`, lines `333-336`.

## Displayed Claim

For every finite `A` contained in the positive integers and every positive
integer `n`, the source displays

```text
|A Delta (2A) Delta ... Delta (nA)| >= n,
```

where `Delta` denotes symmetric difference and `mA={ma:a in A}`.

## Counterexample

Take

```text
A = empty set, n = 1.
```

The empty set is a finite subset of the positive integers, so it satisfies the
displayed domain. Every dilation of it is empty:

```text
mA = empty set
```

for every positive integer `m`. Consequently,

```text
A Delta (2A) Delta ... Delta (nA) = empty set,
```

whose cardinality is `0`. At `n=1`, the displayed inequality therefore reads
`0 >= 1`, which is false.

The surrounding source text makes the boundary clear. Immediately before the
display, the underlying problem ranges over nonempty finite sets. The paper's
large-`n` theorem, its `n<=8` theorem, and its definition of `g(n)` all restore
the nonempty condition. Thus this packet identifies an omitted condition in
the displayed statement; it does not resolve the intended nonempty-set
conjecture.

## Replay

Run from the repository root:

```bash
python3 openconjectures/extended-123-empty-set-counterexample/checkers/replay_counterexample.py
```

The standard-library checker evaluates the exact witness and scans every
subset of `{1,...,8}` for `1<=n<=8`. The empty set violates the displayed
formula for all eight scanned values of `n`; none of the `2,040` scanned
nonempty cases violates it. The checker writes
`data/counterexample_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/replay_counterexample.py` verifies the exact set calculation.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/replay_receipt.json` records replay hashes and the claim boundary.

## Claim Boundary

- The packet disproves OpenConjecture `4736` exactly as displayed in the
  current source.
- The exact witness is `A=empty set, n=1`, with left side `0` and right side
  `1`.
- Adding the condition that `A` is nonempty removes this witness. The intended
  nonempty-set Extended 1-2-3 Conjecture remains outside this packet.
