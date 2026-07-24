import StackSortMotzkinBijection

namespace StackSortMotzkinBijectionMathlib

open HautevilleHouse CanonicalLaneMathlibCore OpenConjecture1878

/-! Pinned Mathlib replay of the source-bound inverse existence theorem. -/
theorem mathlib_rechecks_inverse_row_lengths
    (steps : List MotzkinStep)
    (h : IsMotzkinPath steps) :
    ∃ rows : List Nat, inverseRowLengths steps = some rows := by
  exact inverseRowLengths_exists steps h

end StackSortMotzkinBijectionMathlib
