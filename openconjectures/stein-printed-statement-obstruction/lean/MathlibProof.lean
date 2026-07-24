import SteinDisproof

namespace SteinDisproofMathlib

/-! Pinned Mathlib replay of the absolute-value counterexample. -/
theorem mathlib_rechecks_conjecture_disconfirmation (m : ℕ) (σ c : ℝ) :
    ∃ φ : ℝ → ℝ, LipschitzWith 1 φ ∧
      ∀ g : ℝ → ℝ, ContDiff ℝ 3 g →
        ¬ ∀ y, φ y - c = SteinDisproof.steinOperator m σ g y := by
  exact SteinDisproof.stein_conjecture_disconfirmed m σ c

end SteinDisproofMathlib
