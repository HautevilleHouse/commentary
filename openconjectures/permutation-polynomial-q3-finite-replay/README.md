# Permutation-polynomial conjecture: finite `q=3` replay

This packet checks only the finite restriction `q=3` of the odd-
`q` statement in Sharma--Basnet, *A Weil Sum Approach to Permutation
Polynomials over Quadratic Extensions of Finite Fields*, arXiv:2606.14529v1.

For every `b,c,d ∈ F₉` with `b³ ≠ c`, it checks that

`f(x) = x⁴ + b x³ + c x + d`

is not a permutation of `F₉`. There are exactly 648 admissible triples;
both separate checkers return `648 0` (admissible triples, permutations).

This is an internally verified finite result, not a resolution of the
general odd-`q` conjecture.

## Replay

From the repository root:

```sh
./math_research/replay_pp_q3.sh
```

The replay uses separate Python and Ruby implementations of `F₉`.

## Source and provenance

- Source: https://arxiv.org/abs/2606.14529v1
- Version: v1, submitted 2026-06-12
- Observation date: 2026-07-20
- Packet digest: `d7521a31da60dce09108ecc1735cb81fdaf85b114e0d3ab7a6dfa03f130c9ecd`
- Python checker digest: `c77d1a37cfdb19a1d70b1eed0cea93095998a23d2c786d23229eee53a76f348c`
- Ruby checker digest: `e84237f0514bb176745da2098b0461ca1576233a72f30a1acafa16c0017e43d5`

