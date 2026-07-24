import SLCGMaximumGeneratorCounterexample

namespace SLCGMaximumGeneratorCounterexampleMathlib

/-! Pinned Mathlib replay of the exact n=7 cycle obstruction. -/
theorem mathlib_rechecks_source_exact_counterexample :
    SLCGMaximumGeneratorCounterexample.slcgStep 7 42 = 85 ∧
    SLCGMaximumGeneratorCounterexample.slcgStep 7 85 = 42 ∧
    SLCGMaximumGeneratorCounterexample.predictedMaximum 7 = 20 ∧
    SLCGMaximumGeneratorCounterexample.predictedMaximum 7 < 42 := by
  exact ⟨by norm_num [SLCGMaximumGeneratorCounterexample.slcgStep],
    by norm_num [SLCGMaximumGeneratorCounterexample.slcgStep],
    by norm_num [SLCGMaximumGeneratorCounterexample.predictedMaximum],
    by norm_num [SLCGMaximumGeneratorCounterexample.predictedMaximum]⟩

end SLCGMaximumGeneratorCounterexampleMathlib
