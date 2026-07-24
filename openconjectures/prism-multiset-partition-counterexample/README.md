# Prism Multiset-Partition Counterexample

## Summary

This packet gives five explicitly listed parts that resolve the relevant
vertices of the prism graph, disproving the source's claimed universal value
at the first displayed case. Run `./replay.sh` to check the partition.

Source paper: Azzah Albejania, Yuqing Lin, Joe Ryan, and Kiki A. Sugeng,
[Multiset Partition Dimension of Graphs](https://arxiv.org/abs/2607.07407v1).

Source object: OpenConjecture `4479`, arXiv:`2607.07407v1`, Conjecture 1
in `EJGTATemplate.tex`, lines `785-791`, read with the definition at lines
`132-151`.

## Source Claim

For a vertex partition `Pi = {S_1,...,S_t}`, the source defines the multiset
partition representation of a vertex `v` to be the unordered multiset

```text
{d(v,S_1), ..., d(v,S_t)},
```

where `d(v,S_i)` is the minimum graph distance from `v` to a vertex in
`S_i`. A partition resolves the graph when these multisets are different for
every pair of vertices. The conjecture states

```text
mpd(P_m) = 6 for every m >= 8,
```

where `P_m` is the prism graph formed from two `m`-cycles and the matching
between corresponding vertices.

## Counterexample

Take `m=8`. Label the vertices of `P_8` by `(i,j)`, where `i` is `0` or `1`
and `j` is read modulo `8`. Join `(i,j)` to `(i,j-1)`, `(i,j+1)`, and
`(1-i,j)`.

Partition the vertices into five parts:

```text
S_1 = {(0,0)}
S_2 = {(0,1)}
S_3 = {(0,3)}
S_4 = {(0,5)}
S_5 = V(P_8) \ {(0,0),(0,1),(0,3),(0,5)}.
```

The sorted distance multisets are:

| Vertex | Multiset representation |
|---|---|
| `(0,0)` | `(0,1,1,3,3)` |
| `(0,1)` | `(0,1,1,2,4)` |
| `(0,2)` | `(0,1,1,2,3)` |
| `(0,3)` | `(0,1,2,2,3)` |
| `(0,4)` | `(0,1,1,3,4)` |
| `(0,5)` | `(0,1,2,3,4)` |
| `(0,6)` | `(0,1,2,3,3)` |
| `(0,7)` | `(0,1,2,2,4)` |
| `(1,0)` | `(0,1,2,4,4)` |
| `(1,1)` | `(0,1,2,3,5)` |
| `(1,2)` | `(0,2,2,3,4)` |
| `(1,3)` | `(0,1,3,3,4)` |
| `(1,4)` | `(0,2,2,4,5)` |
| `(1,5)` | `(0,1,3,4,5)` |
| `(1,6)` | `(0,2,3,4,4)` |
| `(1,7)` | `(0,2,3,3,5)` |

All 16 multisets are distinct. Thus this is a resolving multiset partition
with five parts, so

```text
mpd(P_8) <= 5 < 6.
```

This contradicts Conjecture 1. It also conflicts with the source's prose that
computer verification gave `mpd(P_m)=6` through `m=70`; this packet does not
attempt to diagnose that computation.

## Verification

Run from the repository root:

```bash
python3 openconjectures/prism-multiset-partition-counterexample/checkers/verify_counterexample.py
```

The standard-library checker constructs `P_8`, checks that the five parts are
a partition, computes graph distances by multi-source breadth-first search,
and verifies that all 16 unordered representations are distinct. It writes
`data/counterexample_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/verify_counterexample.py` verifies the witness from the graph
  definition.
- `data/counterexample_check_20260717.json` records all representations.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/verification_receipt.json` records checker hashes and the claim
  boundary.

## Claim Boundary

- The packet refutes the exact universal statement of Conjecture 1 with the
  admissible prism `P_8`.
- The packet proves only `mpd(P_8) <= 5`; it does not claim that the exact
  value is `5` rather than `4`.
- The packet does not classify the values of `mpd(P_m)` for other `m`.
- The packet does not diagnose the source's reported computation through
  `m=70`.
