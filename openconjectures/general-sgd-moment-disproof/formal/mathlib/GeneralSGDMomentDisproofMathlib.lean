import GeneralSGDMomentDisproof

namespace GeneralSGDMomentDisproofMathlib

/-! Pinned Mathlib-environment replay of the packet's moment obstruction. -/
theorem mathlib_rechecks_moment_boundary :
    Integrable (fun n => GeneralSGDMomentDisproof.attemptSixteenNoise n ^ 3)
      GeneralSGDMomentDisproof.attemptSixteenGeomMeasure ∧
    ¬ Integrable (fun n => GeneralSGDMomentDisproof.attemptSixteenNoise n ^ 6)
      GeneralSGDMomentDisproof.attemptSixteenGeomMeasure := by
  exact ⟨GeneralSGDMomentDisproof.attemptSixteen_noise_thirdMoment_integrable,
    GeneralSGDMomentDisproof.attemptSixteen_noise_sixthMoment_not_integrable⟩

end GeneralSGDMomentDisproofMathlib
