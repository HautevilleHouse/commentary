import VersionBParityCounterexample

namespace VersionBParityCounterexampleMathlib

/-! Pinned Mathlib replay of the finite parity witness and move bridge. -/
theorem mathlib_rechecks_finite_certificate :
    VersionBParityCounterexample.target.length = 12 ∧
    VersionBParityCounterexample.oddCount VersionBParityCounterexample.target = 7 ∧
    VersionBParityCounterexample.removeAll VersionBParityCounterexample.target =
      VersionBParityCounterexample.child := by
  exact ⟨VersionBParityCounterexample.target_length,
    VersionBParityCounterexample.target_odd_count,
    VersionBParityCounterexample.target_all_option⟩

end VersionBParityCounterexampleMathlib
