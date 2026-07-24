/-!
# Graffiti 284 — Hoffman–Singleton algebraic counterexample

This certificate encodes the usual Written-on-the-Wall reading of Graffiti
conjecture 284:

  for a connected simple graph of girth at least 5,
  `min_dual ≤ -λ_min(D)`,

where `min_dual` is the minimum dual degree and `D` is the distance matrix.

It then records the standard Hoffman–Singleton spectral data and the exact
diameter-2 identity `D = 2(J - I) - A`, and proves that the resulting numerical
inequality `7 ≤ 4` is false.

The packet deliberately does **not** construct the Hoffman–Singleton graph
inside Lean. Existence, uniqueness, girth 5, diameter 2, 7-regularity, and the
adjacency spectrum are treated as externally certified source facts; Lean checks
the spectral bridge and the contradiction.

This Lake package is stdlib-only (no Mathlib fetch) so it remains separately
replayable with `lake build` on a clean clone.
-/

namespace Graffiti284HoffmanSingletonCounterexample

/-- Usual WoW reading of Graffiti 284. -/
def graffiti284 (minDual lambdaMinD : Int) : Prop :=
  minDual ≤ -lambdaMinD

/--
For a connected diameter-2 `k`-regular graph on `n` vertices, the all-ones
eigenvalue of the distance matrix is `2(n - 1) - k`.
-/
def distanceAllOnesEigenvalue (n k : Int) : Int :=
  2 * (n - 1) - k

/--
On the orthogonal complement of the all-ones vector, an adjacency eigenvalue
`θ` becomes the distance eigenvalue `-2 - θ`.
-/
def distanceFromAdjacency (θ : Int) : Int :=
  -2 - θ

/-- Standard Hoffman–Singleton parameters used by the bridge. -/
def hsOrder : Int := 50
def hsDegree : Int := 7

theorem hs_all_ones_distance_eigenvalue :
    distanceAllOnesEigenvalue hsOrder hsDegree = 91 := by
  decide

theorem hs_distance_from_adj_two :
    distanceFromAdjacency (2 : Int) = -4 := by
  decide

theorem hs_distance_from_adj_neg_three :
    distanceFromAdjacency (-3 : Int) = 1 := by
  decide

theorem hs_lambda_min_is_neg_four :
    distanceFromAdjacency (2 : Int) = -4 ∧
    distanceFromAdjacency (-3 : Int) = 1 ∧
    (-4 : Int) ≤ 1 ∧
    (-4 : Int) ≤ 91 := by
  decide

/--
A 7-regular graph has dual degree identically 7, so `min_dual = 7`.
Combined with `λ_min(D) = -4`, Graffiti 284 would require `7 ≤ 4`.
-/
theorem graffiti284_at_hoffman_singleton_numerics :
    graffiti284 hsDegree (-4) ↔ (7 : Int) ≤ 4 := by
  simp [graffiti284, hsDegree]

theorem seven_not_le_four : ¬ ((7 : Int) ≤ 4) := by
  decide

/--
Algebraic counterexample certificate: under the recorded Hoffman–Singleton
spectral bridge, the usual numerical reading of Graffiti 284 fails.
-/
theorem hoffman_singleton_refutes_graffiti284_numerics :
    ¬ graffiti284 hsDegree (-4) := by
  rw [graffiti284_at_hoffman_singleton_numerics]
  exact seven_not_le_four

/--
Margin check: `min_dual + λ_min(D) = 3 > 0`, so the signed score used by
automated search tables is strictly positive (a counterexample score).
-/
theorem hoffman_singleton_counterexample_margin :
    hsDegree + (-4 : Int) = 3 := by
  decide

/--
Petersen sanity check used in the dual-checker: adjacency spectrum
`{3,1,-2}` on the diameter-2 3-regular Petersen graph yields distance spectrum
`{15,-3,0}`, so `min_dual + λ_min(D) = 0` (tight, not a counterexample).
-/
theorem petersen_distance_from_adjacency :
    distanceFromAdjacency (1 : Int) = -3 ∧
    distanceFromAdjacency (-2 : Int) = 0 ∧
    distanceAllOnesEigenvalue 10 3 = 15 := by
  decide

end Graffiti284HoffmanSingletonCounterexample
