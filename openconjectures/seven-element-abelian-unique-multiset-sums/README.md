# Seven-Element Unique Multiset Sums in Finite Abelian Groups

Source paper: José A. R. Fonollosa,
[Minimum modulus for the unique multiset-sum problem](https://arxiv.org/abs/2607.08366v2),
arXiv:`2607.08366v2`.

Source object: Open Problem 4 in Section 8, "Beyond cyclic groups."

## Source Question

Let `g_0,...,g_6` be seven elements of a finite abelian group `G`, and put

```text
t = g_0 + ... + g_6.
```

They have unique multiset sums when the only nonnegative integer vector
`(k_0,...,k_6)` satisfying

```text
k_0 + ... + k_6 = 7
k_0 g_0 + ... + k_6 g_6 = t
```

is `(1,1,1,1,1,1,1)`. The source asks whether the least possible group order
for `n` elements is `2^(n-1)` for every `n`. It records exhaustive confirmation
through `n=6` and proves the statement for elementary abelian `2`-groups for
all `n`.

## Theorem

The least order of a finite abelian group containing seven elements with unique
multiset sums is

```text
64.
```

This resolves the `n=7` case of the source's all-finite-abelian-group question.

## Lower Bound

### Orders below 35

Every three-element subset of `{g_0,...,g_6}` must have a distinct sum. If two
distinct triples `S` and `T` had equal sums, then

```text
(1,...,1) + 1_S - 1_T
```

would be a different nonnegative size-seven multiplicity vector with the same
target sum. There are `C(7,3)=35` triples, so `|G| >= 35`.

### Orders 35 through 63

The fundamental classification of finite abelian groups reduces these 29
orders to 49 isomorphism types. The replay enumerates every type exactly.

For each group:

1. Translation invariance permits one selected element to be zero.
2. Repeated selected elements are impossible, so the remaining six elements
   are enumerated in increasing encoded order.
3. Colliding sums of distinct two- or three-element subsets reject a candidate
   because either collision yields a competing size-seven multiset.
4. Every surviving seven-set is checked against all
   `C(13,6)=1716` nonnegative multiplicity vectors of total size seven.

The primary search also applies a sound prefix condition: a competing
size-`d` multiset on a `d`-element prefix remains a competing size-seven
multiset after one copy of every later element is added. An unpruned mode
removes this condition. A separately implemented checker recomputes the
two- and three-subset conditions from each whole prefix and performs the full
definition check separately.

All 49 group types were exhausted. The primary unpruned search and the separate
checker agreed exactly on

```text
48,167,516 search nodes
10,985,184 directly checked seven-sets
0 valid seven-sets
```

## Upper Bound

In `G=(Z/2Z)^6`, take

```text
g_0 = 0,  g_i = e_i for 1 <= i <= 6.
```

If a size-seven multiplicity vector reaches the all-ones target, then every
`k_i` for `1 <= i <= 6` is odd. Hence each is at least one. If any were at
least three, their total would already be at least eight. Therefore all six
equal one, and the total-size condition forces `k_0=1`. The construction has
unique multiset sums and `|G|=64`.

The replay also checks this construction directly against all 1,716
multiplicity vectors and finds exactly the all-ones preimage.

## Replay

Requirements:

- Python 3;
- a C++20 compiler available as `clang++`;
- no third-party Python packages.

Run from the repository root:

```bash
python3 openconjectures/seven-element-abelian-unique-multiset-sums/checkers/verify.py
```

The verifier compiles both search programs in a fresh temporary directory,
regenerates all finite abelian group types of orders 35 through 63, requires
complete exhaustion, compares exact node and candidate counts, and checks the
order-64 construction. Its final standard-output line is the machine-readable
result in `data/verification_result_20260718.json`.

## Files

- `checkers/unique_multiset_group_search.cpp` is the primary exact search.
- `checkers/unique_multiset_group_crosscheck.cpp` is the separately implemented
  exact checker.
- `checkers/verify.py` compiles and coordinates both programs.
- `data/group_types_35_63.json` lists every classified group type supplied to
  the searches.
- `data/source_identity.json` records the versioned source object and hashes.
- `data/prior_public_resolution_search_20260718.json` records the bounded public-resolution search receipt.
- `data/verification_result_20260718.json` records the exact result.
- `data/replay_receipt.json` records commands, tool versions, and packet hashes.

## Claim Boundary

- The theorem settles the seven-element case over all finite abelian groups.
- The source's cases `n>=8` remain open.
- The source's cyclic Conjecture 1 is a separate statement; the source already
  records an exact cyclic certificate through `n=7`.
- Classification of every order-64 extremizer remains outside this packet.
- The lower bound from 35 through 63 is computer-assisted and depends on the
  publicly replayable exhaustive search.
- The prior-resolution search is dated and bounded; unpublished, unindexed, or
  differently worded work remains outside its scope.
