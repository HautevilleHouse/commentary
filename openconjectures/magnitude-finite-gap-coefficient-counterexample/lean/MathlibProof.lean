import MagnitudeDisproof

open Filter

namespace MagnitudeDisproofMathlib

/-! Pinned Mathlib replay of the determinant-gap obstruction. -/
theorem mathlib_rechecks_limit_obstruction :
    ¬ Tendsto (fun r : ℝ => MagnitudeDisproof.attemptNineDet r / r ^ 2)
      (nhdsWithin 0 (Set.Ioi 0)) (nhds 16) := by
  exact MagnitudeDisproof.attemptNineDet_div_rsq_not_tendsto_conjectured

end MagnitudeDisproofMathlib
