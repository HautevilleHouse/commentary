import Mathlib

namespace GeneralSGDMomentDisproof

open MeasureTheory Filter
open scoped Topology BigOperators

noncomputable section

/--
A geometric law with success probability `15/16`. Together with the dyadic random variable
`n ↦ 2^n`, this gives the one-coordinate heavy-tail input for the repaired Attempt 16
counterexample.

This opening block isolates the finite-third / infinite-sixth moment calculation that is later
reused in the centered AR(1) construction. It is still separate from the separate literal
printed-statement theorem `attemptSixteen_conjecture_disconfirmed` below.
-/
def attemptSixteenGeomPmf : PMF ℕ :=
  ProbabilityTheory.geometricPMF (p := (15 : ℝ) / 16) (by norm_num) (by norm_num)

def attemptSixteenGeomMeasure : Measure ℕ :=
  attemptSixteenGeomPmf.toMeasure

def attemptSixteenNoise : ℕ → ℝ :=
  fun n ↦ (2 : ℝ) ^ n

@[simp]
lemma attemptSixteenGeomMeasure_singleton (n : ℕ) :
    attemptSixteenGeomMeasure {n} = ENNReal.ofReal (((1 / 16 : ℝ) ^ n) * (15 / 16)) := by
  rw [attemptSixteenGeomMeasure,
    PMF.toMeasure_apply_singleton attemptSixteenGeomPmf n (MeasurableSet.singleton n)]
  norm_num [attemptSixteenGeomPmf, ProbabilityTheory.geometricPMF,
    ProbabilityTheory.geometricPMFReal]
  rfl

lemma attemptSixteenNoise_pow_three (n : ℕ) :
    attemptSixteenNoise n ^ 3 = (8 : ℝ) ^ n := by
  calc
    attemptSixteenNoise n ^ 3 = ((2 : ℝ) ^ n) ^ 3 := by rfl
    _ = (2 : ℝ) ^ (n * 3) := by rw [pow_mul]
    _ = (2 : ℝ) ^ (3 * n) := by rw [Nat.mul_comm]
    _ = ((2 : ℝ) ^ 3) ^ n := by rw [pow_mul]
    _ = (8 : ℝ) ^ n := by norm_num

lemma attemptSixteenNoise_pow_six (n : ℕ) :
    attemptSixteenNoise n ^ 6 = (64 : ℝ) ^ n := by
  calc
    attemptSixteenNoise n ^ 6 = ((2 : ℝ) ^ n) ^ 6 := by rfl
    _ = (2 : ℝ) ^ (n * 6) := by rw [pow_mul]
    _ = (2 : ℝ) ^ (6 * n) := by rw [Nat.mul_comm]
    _ = ((2 : ℝ) ^ 6) ^ n := by rw [pow_mul]
    _ = (64 : ℝ) ^ n := by norm_num

lemma attemptSixteen_thirdMoment_term (n : ℕ) :
    ENNReal.ofReal (attemptSixteenNoise n ^ 3) * attemptSixteenGeomMeasure {n} =
      ENNReal.ofReal (15 / 16 : ℝ) * (ENNReal.ofReal (1 / 2 : ℝ) ^ n) := by
  rw [attemptSixteenNoise_pow_three, attemptSixteenGeomMeasure_singleton]
  have hreal :
      (8 : ℝ) ^ n * ((1 / 16 : ℝ) ^ n * (15 / 16))
        = (15 / 16 : ℝ) * ((1 / 2 : ℝ) ^ n) := by
    calc
      (8 : ℝ) ^ n * ((1 / 16 : ℝ) ^ n * (15 / 16))
          = ((8 : ℝ) ^ n * (1 / 16 : ℝ) ^ n) * (15 / 16) := by ring
      _ = ((8 : ℝ) * (1 / 16 : ℝ)) ^ n * (15 / 16) := by rw [← mul_pow]
      _ = ((1 / 2 : ℝ) ^ n) * (15 / 16) := by norm_num
      _ = (15 / 16 : ℝ) * ((1 / 2 : ℝ) ^ n) := by ring
  have h8_nonneg : 0 ≤ (8 : ℝ) ^ n := by positivity
  have hgeom_nonneg : 0 ≤ ((1 / 16 : ℝ) ^ n) * (15 / 16) := by positivity
  have hconst_nonneg : 0 ≤ (15 / 16 : ℝ) := by positivity
  rw [← ENNReal.ofReal_mul h8_nonneg, hreal, ENNReal.ofReal_mul hconst_nonneg]
  rw [ENNReal.ofReal_pow (by positivity : 0 ≤ (1 / 2 : ℝ)) n]

lemma attemptSixteen_firstMoment_term (n : ℕ) :
    ENNReal.ofReal (attemptSixteenNoise n) * attemptSixteenGeomMeasure {n} =
      ENNReal.ofReal (15 / 16 : ℝ) * (ENNReal.ofReal (1 / 8 : ℝ) ^ n) := by
  rw [attemptSixteenGeomMeasure_singleton]
  have hreal :
      (2 : ℝ) ^ n * ((1 / 16 : ℝ) ^ n * (15 / 16))
        = (15 / 16 : ℝ) * ((1 / 8 : ℝ) ^ n) := by
    calc
      (2 : ℝ) ^ n * ((1 / 16 : ℝ) ^ n * (15 / 16))
          = ((2 : ℝ) ^ n * (1 / 16 : ℝ) ^ n) * (15 / 16) := by ring
      _ = ((2 : ℝ) * (1 / 16 : ℝ)) ^ n * (15 / 16) := by rw [← mul_pow]
      _ = ((1 / 8 : ℝ) ^ n) * (15 / 16) := by norm_num
      _ = (15 / 16 : ℝ) * ((1 / 8 : ℝ) ^ n) := by ring
  have h2_nonneg : 0 ≤ (2 : ℝ) ^ n := by positivity
  have hgeom_nonneg : 0 ≤ ((1 / 16 : ℝ) ^ n) * (15 / 16) := by positivity
  have hconst_nonneg : 0 ≤ (15 / 16 : ℝ) := by positivity
  rw [attemptSixteenNoise, ← ENNReal.ofReal_mul h2_nonneg, hreal, ENNReal.ofReal_mul hconst_nonneg]
  rw [ENNReal.ofReal_pow (by positivity : 0 ≤ (1 / 8 : ℝ)) n]

lemma attemptSixteen_sixthMoment_term (n : ℕ) :
    ENNReal.ofReal (attemptSixteenNoise n ^ 6) * attemptSixteenGeomMeasure {n} =
      ENNReal.ofReal (15 / 16 : ℝ) * (ENNReal.ofReal (4 : ℝ) ^ n) := by
  rw [attemptSixteenNoise_pow_six, attemptSixteenGeomMeasure_singleton]
  have hreal :
      (64 : ℝ) ^ n * ((1 / 16 : ℝ) ^ n * (15 / 16))
        = (15 / 16 : ℝ) * ((4 : ℝ) ^ n) := by
    calc
      (64 : ℝ) ^ n * ((1 / 16 : ℝ) ^ n * (15 / 16))
          = ((64 : ℝ) ^ n * (1 / 16 : ℝ) ^ n) * (15 / 16) := by ring
      _ = ((64 : ℝ) * (1 / 16 : ℝ)) ^ n * (15 / 16) := by rw [← mul_pow]
      _ = ((4 : ℝ) ^ n) * (15 / 16) := by norm_num
      _ = (15 / 16 : ℝ) * ((4 : ℝ) ^ n) := by ring
  have h64_nonneg : 0 ≤ (64 : ℝ) ^ n := by positivity
  have hgeom_nonneg : 0 ≤ ((1 / 16 : ℝ) ^ n) * (15 / 16) := by positivity
  have hconst_nonneg : 0 ≤ (15 / 16 : ℝ) := by positivity
  have hfour_nonneg : 0 ≤ (4 : ℝ) ^ n := by positivity
  rw [← ENNReal.ofReal_mul h64_nonneg, hreal, ENNReal.ofReal_mul hconst_nonneg]
  simp

/--
The dyadic heavy-tail witness already has finite first moment under the geometric law.
-/
theorem attemptSixteen_noise_firstMoment_integrable :
    Integrable attemptSixteenNoise attemptSixteenGeomMeasure := by
  refine ⟨(measurable_of_countable _).aestronglyMeasurable, ?_⟩
  rw [hasFiniteIntegral_iff_ofReal]
  · rw [MeasureTheory.lintegral_countable']
    simp_rw [attemptSixteen_firstMoment_term]
    rw [ENNReal.tsum_mul_left, ENNReal.tsum_geometric]
    have hOneEighth : ENNReal.ofReal (1 / 8 : ℝ) = (1 / 8 : ENNReal) := by
      rw [one_div, ENNReal.ofReal_inv_of_pos (by norm_num)]
      norm_num
    have hgeom_ne_top : (1 - (1 / 8 : ENNReal))⁻¹ ≠ ⊤ := by
      rw [ENNReal.inv_ne_top]
      exact ne_of_gt (by norm_num : (0 : ENNReal) < 1 - (1 / 8 : ENNReal))
    rw [hOneEighth]
    exact lt_top_iff_ne_top.2 <| ENNReal.mul_ne_top ENNReal.ofReal_ne_top hgeom_ne_top
  · exact Filter.Eventually.of_forall fun n ↦ by
      dsimp [attemptSixteenNoise]
      positivity

/--
The dyadic heavy-tail witness has finite third moment under the geometric law.
-/
theorem attemptSixteen_noise_thirdMoment_integrable :
    Integrable (fun n ↦ attemptSixteenNoise n ^ 3) attemptSixteenGeomMeasure := by
  refine ⟨(measurable_of_countable _).aestronglyMeasurable, ?_⟩
  rw [hasFiniteIntegral_iff_ofReal]
  · rw [MeasureTheory.lintegral_countable']
    simp_rw [attemptSixteen_thirdMoment_term]
    rw [ENNReal.tsum_mul_left, ENNReal.tsum_geometric]
    have hhalf : ENNReal.ofReal (1 / 2 : ℝ) = (1 / 2 : ENNReal) := by
      rw [one_div, ENNReal.ofReal_inv_of_pos (by norm_num)]
      norm_num
    have hgeom : (1 - (1 / 2 : ENNReal))⁻¹ = (2 : ENNReal) := by
      norm_num
    rw [hhalf, hgeom]
    exact lt_top_iff_ne_top.2 <| ENNReal.mul_ne_top ENNReal.ofReal_ne_top (by simp)
  · exact Filter.Eventually.of_forall fun n ↦ by
      dsimp [attemptSixteenNoise]
      positivity

/--
The same witness has divergent sixth moment, showing the gap in Attempt 16's conjectured
`3h`-moment conclusion already in the quadratic (`h = 2`) regime.
-/
theorem attemptSixteen_noise_sixthMoment_not_integrable :
    ¬ Integrable (fun n ↦ attemptSixteenNoise n ^ 6) attemptSixteenGeomMeasure := by
  intro hInt
  have hfi := hInt.hasFiniteIntegral
  rw [hasFiniteIntegral_iff_ofReal] at hfi
  · rw [MeasureTheory.lintegral_countable'] at hfi
    simp_rw [attemptSixteen_sixthMoment_term] at hfi
    rw [ENNReal.tsum_mul_left, ENNReal.tsum_geometric] at hfi
    have hfour : ENNReal.ofReal (4 : ℝ) = (4 : ENNReal) := by
      norm_num
    have hgeom : (1 - ENNReal.ofReal (4 : ℝ))⁻¹ = (⊤ : ENNReal) := by
      rw [hfour]
      have hsub : (1 - (4 : ENNReal)) = 0 := by
        exact tsub_eq_zero_of_le (by norm_num : (1 : ENNReal) ≤ 4)
      rw [hsub]
      simp
    rw [hgeom] at hfi
    norm_num at hfi
  · exact Filter.Eventually.of_forall fun n ↦ by
      dsimp [attemptSixteenNoise]
      positivity

end

end GeneralSGDMomentDisproof
