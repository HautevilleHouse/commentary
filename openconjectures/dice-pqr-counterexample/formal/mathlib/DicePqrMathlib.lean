import Mathlib.Data.Fin.Basic
import DicePqrCounterexample

namespace DicePqrCounterexampleMathlib

/- The exact finite certificate is imported from the packet's native Lean
   source and rechecked in the pinned Mathlib environment. -/
theorem mathlib_environment_rechecks_certificate :
    DicePqrCounterexample.certificate.openConjectureId = 3558 ∧
    DicePqrCounterexample.certificate.p = 3 ∧
    DicePqrCounterexample.certificate.q = 5 ∧
    DicePqrCounterexample.certificate.r = 11 ∧
    DicePqrCounterexample.certificate.qualifiesAsCounterexampleToSourceInstance = true := by
  native_decide

end DicePqrCounterexampleMathlib
