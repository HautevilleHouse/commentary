# Commentary

This repository is the public commentary shelf for source-bound mathematical notes, counterexample certificates, and replay records.

It keeps commentary work in one repository so the public GitHub account avoids one-off repository sprawl.

## Repository Model

Each commentary note is folder-scoped. A folder owns its source pointer, public claim boundary, replay code, data, and any package manifest needed to check that note.

The root README is only the public index. It should stay small as the note count grows.

[Formal Record](https://github.com/HautevilleHouse/formal-record): the machine-readable index of source versions, bounded outcomes, replay routes, review states, and packet links.

Lean commentary folders should include their own `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json` when they are self-contained and rebuildable. Shared build caches such as `.lake/` stay out of the repository. A Lean package that only builds a shelf marker does not check the packet’s mathematical claim; the receipt and README must say so when that is the case.

Checker commentary folders should include source identity, replay receipt, replay output, deterministic certificate data, and a dependency marker. The receipt records the command, tool version, hashes, endpoint result, closed claim, and carried boundary.

## Start Here

| Note | Source Object | Public Role |
|---|---|---|
| [Almost Golomb Prefix Conjecture](openconjectures/almost-golomb-prefix-conjecture/) | arXiv:2604.02404v1, Prefix Conjecture in Section 9.1 | Proof that `a_r(r)=G(r-1)` for every `r>=3`; the separate Domination Lemma and full threshold law remain carried |
| [Nine arithmetic-function inequalities](openconjectures/nine-arithmetic-function-inequalities/) | arXiv:2606.12484v1, OpenConjecture 3856-3864 | Proof of all nine source inequalities for every `n>=2` and `k>=1`, with equality exactly when `n` is prime |
| [Directed-cycle avalanche counterexample](openconjectures/avalanche-zero-class-counterexample/) | arXiv:2606.26786v1, OpenConjecture 4244 | Exact `C_3` counterexample: the printed zero-class conjecture predicts `S^0`, while parallel firing produces the triangle boundary `S^1`; the same orbit also contradicts the preceding residue-class lemma as printed |
| [Class-69 involution counterexample](openconjectures/mesh-class69-involution-counterexample/) | arXiv:2606.14367v1, concluding Class-69 conjecture | Exact `S_3` involution counterexample: P1 and P3 have different occurrence-count histograms; the unrestricted Class-69 question remains open |
| [Valley Delta area-two extension](openconjectures/valley-delta-area2-n6m5/) | arXiv:2606.14877v1, Conjecture 8.2, bounded `(n,M)=(6,5)` target | Exhaustive verification of 143,649 diagonal-blind and 149,388 per-diagonal classes, all symmetric; the all-parameter conjecture remains open |
| [Misère escalation m=3 quotient](openconjectures/misere-escalation-m3-quotient/) | arXiv:2606.29015v1, Conjecture C(2), exact move set `{1,2,3}` | Exact five-element misère quotient with Klein-four ideal and loss set `{e}`; the all-`m` conjecture remains open |
| [Bergeron Gaussian bound `<=60`](openconjectures/bergeron-small-n60/) | arXiv:2607.04050v1, coefficientwise conjecture, finite `d<=60` restriction | Exhaustive exact check of 1,173 admissible quadruples and 613,167 coefficients; the unrestricted conjecture remains open |
| [Version B parity-classification counterexample](openconjectures/version-b-parity-counterexample/) | arXiv:2605.23213v1, OpenConjecture 2620 | Exact first-untested-case counterexample, with replay by two finite-game solvers plus a Lean-checked source boundary and logical bridge |
| [S-LCG maximum-generator counterexample](openconjectures/slcg-maximum-generator-counterexample/) | arXiv:2605.05198v1, OpenConjecture 2378 | Lean-checked two-cycle counterexample to the printed maximum-generator formula, with an infinite odd-parameter witness family |
| [Dice Q01 coefficient classification](openconjectures/dice-q01-coefficient-classification/) | arXiv:2606.20311v1, Conjecture 5.7 | Exact classification: nonnegative coefficients occur precisely when `p=2` and `q` is congruent to `1` modulo `4` |
| [Hilbert-depth product inequalities](openconjectures/hilbert-depth-product-inequalities/) | arXiv:2602.09607v1, Conjecture 4.1 | Elementary product-and-tail proof of all four source inequalities for every positive integer `s` |
| [LEGO polynomial reciprocity](openconjectures/lego-polynomial-reciprocity/) | arXiv:2605.07380v1, Conjecture 1 | Ehrhart-reciprocity proof of `p_n(1-w)=(-1)^(n-1)p_n(w)` for every positive integer `n` |
| [Seven-element unique multiset sums](openconjectures/seven-element-abelian-unique-multiset-sums/) | arXiv:2607.08366v2, Open Problem 4 | Computer-assisted resolution of the seven-element case: the least order over all finite abelian groups is `64` |
| [Symmetry-efficiency subgroup restriction](openconjectures/symmetry-efficiency-subgroup-restriction-proof/) | arXiv:2607.00988v1, OpenConjecture 4732 | Subgroup-restriction proof of the source-defined `m*` monotonicity claim |
| [Circulant path-homology counterexample](openconjectures/circulant-path-homology-counterexample/) | arXiv:2602.04140v1, OpenConjecture 686 | Exact `C_13^{1,4,6}` counterexample to the universal path-homology claim |
| [Odd-cycle cyclic-interval proof](openconjectures/odd-cycle-cyclic-interval-proof/) | arXiv:2607.07939v1, OpenConjecture 4448 | Averaging proof yielding `k_min(C_m)=m-1` for every odd cycle |
| [Prism multiset-partition counterexample](openconjectures/prism-multiset-partition-counterexample/) | arXiv:2607.07407v1, OpenConjecture 4479 | Five-part resolving partition of `P_8`, refuting the claimed value `6` for every `m>=8` |
| [Triangular prism domination-packing counterexample](openconjectures/triangular-prism-domination-packing-counterexample/) | arXiv:2606.29199v1, OpenConjecture 4867 | Exact six-vertex counterexample: the bridgeless claw-free cubic triangular prism has `gamma=2` and `rho=1`, violating `gamma<=5rho/4` |
| [Cardioid subsampling counterexample](openconjectures/cardioid-subsampling-counterexample/) | arXiv:2607.03186v1, OpenConjecture 4648 | Exact Fourier-mode counterexample showing that the nonuniform cardioid family is closed under the source fixed-step `r=2` transform |
| [Extended 1-2-3 displayed-statement counterexample](openconjectures/extended-123-empty-set-counterexample/) | arXiv:2607.00934v1, OpenConjecture 4736 | Exact empty-set counterexample to the displayed quantifier, with the intended nonempty domain carried explicitly |
| [CRIM rectair boundary counterexample](openconjectures/crim-rectair-boundary-counterexample/) | arXiv:2606.16828v1, OpenConjecture 3659 | Exact `r=1, k=0` Sprague-Grundy counterexample, with the repaired `r>=2` domain carried explicitly |
| [CRIM non-hook Conway-pair counterexample family](openconjectures/crim-cp01-nonhook-family/) | arXiv:2606.16828v1, Conjecture 6 (`conj:hookswap`) | Parametric non-hook family `[m,2]`, `m>=2`, with Conway pair `(0,1)` |
| [Vieta r=2 normalized values](openconjectures/vieta-r2-normalized-values/) | arXiv:2605.19083v2, OpenConjecture 2765 | Symbolic proof of Conjecture 4.2 with reproducible arithmetic checks and an explicit general-`r` boundary |
| [Dice pqr counterexample](openconjectures/dice-pqr-counterexample/) | arXiv:2606.20311v1, Conjecture `con:pqr` | Source-worded counterexample certificate with replay script and bounded instance index |
| [Graphical r-Stirling monotonicity](openconjectures/graphical-r-stirling-monotonicity/) | arXiv:2602.02046v1, OpenConjecture 746 | Proof of the displayed weak chain, exact strictness criterion, and positive-count counterexample to the strict gloss |
| [General SGD moment disproof](openconjectures/general-sgd-moment-disproof/) | arXiv:2602.13960v1, OpenConjecture 367 | Lean-checked bounded disproof packet for the encoded literal and repaired-centered routes |
| [LAWS coupon counterexample](openconjectures/laws-coupon-counterexample/) | arXiv:2605.04069v1, OpenConjecture 2421 | Source-worded counterexample to the expert-creation lower-bound wording |
| [Maximal symmetric modulus counterexample](openconjectures/maximal-symmetric-modulus-counterexample/) | arXiv:2606.15624v2, OpenConjecture 3706 | Source-worded `2 x 2` trace counterexample to the `c_vee(d)=1` conjecture |
| [Magnitude finite-gap coefficient counterexample](openconjectures/magnitude-finite-gap-coefficient-counterexample/) | arXiv:2603.04271v1, OpenConjecture 756 | Lean-checked `ell_1^1` finite-gap counterfamily to the universal coefficient statement |
| [Stein printed-statement obstruction](openconjectures/stein-printed-statement-obstruction/) | arXiv:2602.13960v1, OpenConjecture 368 | Lean-checked absolute-value obstruction to the printed Stein solution statement |
| [Stack-sort Motzkin bijection](openconjectures/stack-sort-motzkin-bijection/) | arXiv:2604.10779v2, OpenConjecture 1878 | Lean-checked inverse/forward roundtrip packet for the two-column stack-sorting to Motzkin-path encoding |
| [q-Catalan bivariate n=6 replay](openconjectures/qcatalan-bivariate-n6/) | arXiv:2605.14682v1 | All seven `k` slices agree over 132 312-avoiding permutations; the all-`n` conjecture remains open |
| [q-Catalan full bivariate proof](openconjectures/qcatalan-bivariate-full-proof/) | arXiv:2605.14682v1 | Source-faithful proof for `0<=k<n`, with the conditional saturated `k=n` boundary explicitly disclosed |
| [Book-graph real-root `n=5` replay](openconjectures/book-graph-n5-finite-replay/) | arXiv:2604.08998v2, Conjecture 5.4 | Exact rational Sturm replay for `D(B_5,x)/x^2`: `0` roots in `(-infinity,-2)`, `0` in `(-2,-1/2)`, and `2` in `(-1/2,0)`; the all-`n` conjecture remains open |
| [Odd-q permutation-polynomial q=9 replay](openconjectures/permutation-polynomial-q9-finite-replay/) | arXiv:2606.14529v1 | Exhaustive `F_81` finite slice: 524,880 admissible triples, zero permutation witnesses; general odd-q conjecture remains open |
| [Reported dimension-3 Jacobian counterexample](openconjectures/jacobian-c3-counterexample/) | arXiv:2606.22041v1 structural context; displayed map sealed in packet certificates | Lean-formalized replay; SymPy checks the global determinant `-2`, Lean checks collisions, rescaling, and non-injectivity |
| [Rank-2 Poisson conjecture counterexample](openconjectures/poisson-pc2-counterexample/) | `octonion/mathematics` `poisson/` writeup (2026-07-21), pinned commit in packet source identity | SymPy exact replay of Poisson brackets, `det J=1`, and three-point fiber; `JC(2)` and Lean formalization of this witness remain carried |
| [Goemans finite cost-conjecture counterexample](openconjectures/goemans-cost-counterexample/) | arXiv:2308.02651v1, Conjecture 1.3 | Exact seven-vertex finite instance; exhaustive Python/Ruby replay and delegated review agree that no unsplittable flow satisfies both source conditions; general conjecture remains open |
| [Graffiti 284 Hoffman–Singleton counterexample](openconjectures/graffiti-284-hoffman-singleton-counterexample/) | Graffiti / Written on the Wall conjecture 284 | Algebraic diameter-2 spectral bridge: Hoffman–Singleton gives `min_dual=7` and `λ_min(D)=-4`, so `7 ≰ 4`; Lean/mathlib checks the bridge and contradiction; public statement proxies sealed; Fajtlowicz WoW master list remains an external request-only remainder |

## Scope

| [Kotzig 13-edge T-tree cyclic K27 slice](openconjectures/kotzig-t13-cyclic-k27/) | Formal Conjectures `KotzigConjecture.lean` | Twenty-seven shifts partition `K27`; general Kotzig remains open |
| [Kotzig 12-edge T-tree cyclic K25 slice](openconjectures/kotzig-t12-cyclic-k25/) | Formal Conjectures `KotzigConjecture.lean` | Twenty-five shifts partition `K25`; general Kotzig remains open |
| [Kotzig 11-edge T-tree cyclic K23 slice](openconjectures/kotzig-t11-cyclic-k23/) | Formal Conjectures `KotzigConjecture.lean` | Twenty-three shifts partition `K23`; general Kotzig remains open |
| [Kotzig 10-edge T-tree cyclic K21 slice](openconjectures/kotzig-t10-cyclic-k21/) | Formal Conjectures `KotzigConjecture.lean` | Twenty-one shifts partition `K21`; general Kotzig remains open |
| [Kotzig 9-edge T-tree cyclic K19 slice](openconjectures/kotzig-t9-cyclic-k19/) | Formal Conjectures `KotzigConjecture.lean` | Nineteen shifts partition `K19`; general Kotzig remains open |
| [Kotzig 8-edge T-tree cyclic K17 slice](openconjectures/kotzig-t8-cyclic-k17/) | Formal Conjectures `KotzigConjecture.lean` | Seventeen shifts partition `K17`; general Kotzig remains open |
| [Kotzig 6-edge T-tree cyclic K13 slice](openconjectures/kotzig-t6-cyclic-k13/) | Formal Conjectures `KotzigConjecture.lean` | Thirteen shifts partition `K13`; general Kotzig remains open |
| [Kotzig 5-edge T-tree cyclic K11 slice](openconjectures/kotzig-t5-cyclic-k11/) | Formal Conjectures `KotzigConjecture.lean` | Eleven shifts partition `K11`; general Kotzig remains open |
| [Kotzig T-tree cyclic K9 slice](openconjectures/kotzig-t4-cyclic-k9/) | Formal Conjectures `KotzigConjecture.lean` | Nine cyclic shifts of a 4-edge T-tree partition `K9`; general Kotzig remains open |
| [Formal Conjectures curling-number length-3 replay](openconjectures/formal-curling-length3-bounded/) | Pinned `CurlingNumberConjecture.lean` | Exhaustive 39-case bounded replay; unrestricted conjecture remains open |

Commentary notes in this repository may contain:

- exact source pointers;
- counterexample or correction certificates;
- replay scripts;
- bounded search indexes;
- claim boundaries.

The boundary of this repository is commentary and certificate publication.

Harder work inside that boundary pays on sharper claim boundaries and carried remainders, stronger checkers or Lean companions for the sealed slice, catalog completeness of these outcomes via [Formal Record](https://github.com/HautevilleHouse/formal-record), and occasional elementary proofs when the closed claim is already infinite. Adjacent institutions remain adjacent: DeepMind Formal Conjectures for open Lean statement catalogs, arXiv papers for theory depth, and finished Lean libraries or Mathlib pull requests for hard infinite formalizations. This shelf does not replace those corpora.

## Citation And Rights

All Rights Reserved - No License Granted. Cite the relevant note, source object, and repository URL when discussing, reviewing, comparing, or referencing this material.
