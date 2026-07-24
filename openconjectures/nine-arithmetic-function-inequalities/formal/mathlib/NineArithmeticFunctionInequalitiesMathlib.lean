import NineArithmeticFunctionInequalities

namespace NineArithmeticFunctionInequalitiesMathlib

/-! Pinned Mathlib replay of the source's polynomial nonnegativity lemmas. -/
theorem mathlib_rechecks_leftQ_nonnegative {u v : ℝ}
    (hu : 1 ≤ u) (huv : u ≤ v) :
    0 ≤ NineArithmeticFunctionInequalities.leftQ u v := by
  exact NineArithmeticFunctionInequalities.leftQ_nonnegative hu huv

theorem mathlib_rechecks_rightQ_nonnegative {s t : ℝ}
    (hs0 : 0 ≤ s) (hs1 : s ≤ 1) (ht : 1 ≤ t) :
    0 ≤ NineArithmeticFunctionInequalities.rightQ s t := by
  exact NineArithmeticFunctionInequalities.rightQ_nonnegative hs0 hs1 ht

end NineArithmeticFunctionInequalitiesMathlib
