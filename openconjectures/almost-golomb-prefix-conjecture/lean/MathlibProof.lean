import AlmostGolombPrefix

namespace AlmostGolombPrefixMathlib

/-! Pinned Mathlib-environment replay of the public finite lemma. -/
theorem shift_closed_run_mathlib
    {lo hi n : Nat} (hlo : lo ≤ n) (hhi : n ≤ hi) :
    lo + 1 ≤ n + 1 ∧ n + 1 ≤ hi + 1 := by
  exact AlmostGolombPrefix.shift_closed_run hlo hhi

theorem shifted_run_value_mathlib
    (golomb almost : Nat → Nat) {lo hi n value : Nat}
    (hn : lo ≤ n ∧ n ≤ hi)
    (hgolomb : ∀ k, lo ≤ k → k ≤ hi → golomb k = value)
    (halmost : ∀ k, lo + 1 ≤ k → k ≤ hi + 1 → almost k = value) :
    almost (n + 1) = golomb n := by
  exact AlmostGolombPrefix.shifted_run_value golomb almost hn hgolomb halmost

end AlmostGolombPrefixMathlib
