import MagnitudeDisproof

open scoped Topology
open Filter Matrix

namespace MagnitudeGeneralizationBoundary

open MagnitudeDisproof

/--
The four zero-skeleton vertices of the one-dimensional cubical thickening of
the two-point source set `{0,d}` by radius `r`, ordered along the line when
`0 <= r` and `2 * r <= d`.
-/
def twoPointThickeningVertex (d r : ℝ) : Fin 4 → ℝ
  | 0 => -r
  | 1 => r
  | 2 => d - r
  | _ => d + r

/-- The exponential-kernel similarity matrix on the two-point thickening vertices. -/
noncomputable def twoPointZeroSkeletonSimilarity (d r : ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  fun i j ↦ Real.exp (-|twoPointThickeningVertex d r i - twoPointThickeningVertex d r j|)

/-- The determinant of the two-point cubical-thickening zero-skeleton similarity matrix. -/
noncomputable def twoPointZeroSkeletonDet (d r : ℝ) : ℝ :=
  (twoPointZeroSkeletonSimilarity d r).det

lemma abs_twoPointVertex_zero_one {d r : ℝ} (hr : 0 ≤ r) :
    |twoPointThickeningVertex d r 0 - twoPointThickeningVertex d r 1| = 2 * r := by
  have h : twoPointThickeningVertex d r 0 - twoPointThickeningVertex d r 1 = -(2 * r) := by
    simp [twoPointThickeningVertex]
    ring
  rw [h, abs_neg, abs_of_nonneg]
  linarith

lemma abs_twoPointVertex_zero_two {d r : ℝ} (hd : 0 ≤ d) :
    |twoPointThickeningVertex d r 0 - twoPointThickeningVertex d r 2| = d := by
  have h : twoPointThickeningVertex d r 0 - twoPointThickeningVertex d r 2 = -d := by
    simp [twoPointThickeningVertex]
    ring
  rw [h, abs_neg, abs_of_nonneg hd]

lemma abs_twoPointVertex_zero_three {d r : ℝ} (hd : 0 ≤ d) (hr : 0 ≤ r) :
    |twoPointThickeningVertex d r 0 - twoPointThickeningVertex d r 3| = d + 2 * r := by
  have hnonpos : -d - 2 * r ≤ 0 := by nlinarith
  calc
    |twoPointThickeningVertex d r 0 - twoPointThickeningVertex d r 3| = |-d - 2 * r| := by
      simp [twoPointThickeningVertex]
      ring_nf
    _ = d + 2 * r := by
      rw [abs_of_nonpos hnonpos]
      ring_nf

lemma abs_twoPointVertex_one_two {d r : ℝ} (hgap : 2 * r ≤ d) :
    |twoPointThickeningVertex d r 1 - twoPointThickeningVertex d r 2| = d - 2 * r := by
  have hnonpos : -d + 2 * r ≤ 0 := by linarith
  calc
    |twoPointThickeningVertex d r 1 - twoPointThickeningVertex d r 2| = |-d + 2 * r| := by
      simp [twoPointThickeningVertex]
      ring_nf
    _ = d - 2 * r := by
      rw [abs_of_nonpos hnonpos]
      ring_nf

lemma abs_twoPointVertex_one_three {d r : ℝ} (hd : 0 ≤ d) :
    |twoPointThickeningVertex d r 1 - twoPointThickeningVertex d r 3| = d := by
  have h : twoPointThickeningVertex d r 1 - twoPointThickeningVertex d r 3 = -d := by
    simp [twoPointThickeningVertex]
  rw [h, abs_neg, abs_of_nonneg hd]

lemma abs_twoPointVertex_two_three {d r : ℝ} (hr : 0 ≤ r) :
    |twoPointThickeningVertex d r 2 - twoPointThickeningVertex d r 3| = 2 * r := by
  have h : twoPointThickeningVertex d r 2 - twoPointThickeningVertex d r 3 = -(2 * r) := by
    simp [twoPointThickeningVertex]
    ring
  rw [h, abs_neg, abs_of_nonneg]
  linarith

lemma abs_twoPointVertex_one_zero {d r : ℝ} (hr : 0 ≤ r) :
    |twoPointThickeningVertex d r 1 - twoPointThickeningVertex d r 0| = 2 * r := by
  simpa [abs_sub_comm] using abs_twoPointVertex_zero_one (d := d) hr

lemma abs_twoPointVertex_two_zero {d r : ℝ} (hd : 0 ≤ d) :
    |twoPointThickeningVertex d r 2 - twoPointThickeningVertex d r 0| = d := by
  simpa [abs_sub_comm] using abs_twoPointVertex_zero_two (r := r) hd

lemma abs_twoPointVertex_three_zero {d r : ℝ} (hd : 0 ≤ d) (hr : 0 ≤ r) :
    |twoPointThickeningVertex d r 3 - twoPointThickeningVertex d r 0| = d + 2 * r := by
  simpa [abs_sub_comm] using abs_twoPointVertex_zero_three hd hr

lemma abs_twoPointVertex_two_one {d r : ℝ} (hgap : 2 * r ≤ d) :
    |twoPointThickeningVertex d r 2 - twoPointThickeningVertex d r 1| = d - 2 * r := by
  simpa [abs_sub_comm] using abs_twoPointVertex_one_two hgap

lemma abs_twoPointVertex_three_one {d r : ℝ} (hd : 0 ≤ d) :
    |twoPointThickeningVertex d r 3 - twoPointThickeningVertex d r 1| = d := by
  simpa [abs_sub_comm] using abs_twoPointVertex_one_three (r := r) hd

lemma abs_twoPointVertex_three_two {d r : ℝ} (hr : 0 ≤ r) :
    |twoPointThickeningVertex d r 3 - twoPointThickeningVertex d r 2| = 2 * r := by
  simpa [abs_sub_comm] using abs_twoPointVertex_two_three (d := d) hr

/--
For `0 <= r` and `2*r <= d`, the source zero-skeleton similarity matrix is the
KMS matrix with consecutive line gaps `2r`, `d - 2r`, and `2r`.
-/
theorem twoPointZeroSkeletonSimilarity_eq_kms {d r : ℝ} (hr : 0 ≤ r) (hgap : 2 * r ≤ d) :
    twoPointZeroSkeletonSimilarity d r =
      kmsFour (Real.exp (-2 * r)) (Real.exp (-(d - 2 * r))) (Real.exp (-2 * r)) := by
  have hd : 0 ≤ d := by nlinarith
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [twoPointZeroSkeletonSimilarity, kmsFour,
      abs_twoPointVertex_zero_one (d := d) hr,
      abs_twoPointVertex_zero_two (r := r) hd,
      abs_twoPointVertex_zero_three hd hr,
      abs_twoPointVertex_one_two hgap,
      abs_twoPointVertex_one_three (r := r) hd,
      abs_twoPointVertex_two_three (d := d) hr,
      abs_twoPointVertex_one_zero (d := d) hr,
      abs_twoPointVertex_two_zero (r := r) hd,
      abs_twoPointVertex_three_zero hd hr,
      abs_twoPointVertex_two_one hgap,
      abs_twoPointVertex_three_one (r := r) hd,
      abs_twoPointVertex_three_two (d := d) hr,
      ← Real.exp_add] <;> ring_nf

/-- The source zero-skeleton determinant has the KMS product form. -/
theorem twoPointZeroSkeletonDet_eq {d r : ℝ} (hr : 0 < r) (hgap : 2 * r < d) :
    twoPointZeroSkeletonDet d r =
      (1 - Real.exp (-4 * r)) ^ 2 * (1 - Real.exp (-2 * (d - 2 * r))) := by
  rw [twoPointZeroSkeletonDet, twoPointZeroSkeletonSimilarity_eq_kms hr.le hgap.le, kmsFour_det]
  have hsq₀ : Real.exp (-2 * r) ^ 2 = Real.exp (-4 * r) := by
    rw [sq, ← Real.exp_add]
    ring_nf
  have hsq₁ : Real.exp (-(d - 2 * r)) ^ 2 = Real.exp (-2 * (d - 2 * r)) := by
    rw [sq, ← Real.exp_add]
    ring_nf
  rw [hsq₀, hsq₁]
  ring_nf

/--
The two-point coefficient core for the one-dimensional cubical thickening of
`{0,d}`. The KMS determinant product gives this expression after dividing the
source determinant into the two short gaps `2r` and the middle gap `d - 2r`.
-/
noncomputable def twoPointCoefficientCore (d r : ℝ) : ℝ :=
  ((1 - Real.exp (-4 * r)) / r) ^ 2 * (1 - Real.exp (-2 * (d - 2 * r)))

/-- The normalized two-point core tends to `16 * (1 - exp(-2d))` for every `d > 0`. -/
theorem twoPointCoefficientCore_tendsto (d : ℝ) (_hd : 0 < d) :
    Tendsto (fun r : ℝ ↦ twoPointCoefficientCore d r) (𝓝[>] 0)
      (𝓝 (16 * (1 - Real.exp (-2 * d)))) := by
  have hFirst := tendsto_one_sub_exp_neg4_div
  have hSecond :
      Tendsto (fun r : ℝ ↦ 1 - Real.exp (-2 * (d - 2 * r))) (𝓝[>] 0)
        (𝓝 (1 - Real.exp (-2 * d))) := by
    have hCont : Continuous fun r : ℝ ↦ 1 - Real.exp (-2 * (d - 2 * r)) := by
      continuity
    have hWithin :
        ContinuousWithinAt (fun r : ℝ ↦ 1 - Real.exp (-2 * (d - 2 * r))) (Set.Ioi 0) 0 :=
      hCont.continuousAt.continuousWithinAt
    simpa using hWithin.tendsto
  have hTarget :
      Tendsto
        (fun r : ℝ ↦ ((1 - Real.exp (-4 * r)) / r) ^ 2 *
          (1 - Real.exp (-2 * (d - 2 * r))))
        (𝓝[>] 0) (𝓝 (16 * (1 - Real.exp (-2 * d)))) := by
    convert (hFirst.pow 2).mul hSecond using 1
    · ext r
      ring_nf
  simpa [twoPointCoefficientCore] using hTarget

/-- The conjectured universal coefficient `16` is not this limit for any `d > 0`. -/
theorem twoPointCoefficientCore_not_tendsto_conjectured (d : ℝ) (hd : 0 < d) :
    ¬ Tendsto (fun r : ℝ ↦ twoPointCoefficientCore d r) (𝓝[>] 0) (𝓝 (16 : ℝ)) := by
  intro h
  have hEq :
      (16 * (1 - Real.exp (-2 * d))) = 16 :=
    tendsto_nhds_unique (twoPointCoefficientCore_tendsto d hd) h
  have hlt : 16 * (1 - Real.exp (-2 * d)) < 16 := by
    have hpos : 0 < Real.exp (-2 * d) := Real.exp_pos (-2 * d)
    nlinarith
  linarith

/--
The source zero-skeleton determinant bridge: for the two-point source set `{0,d}`,
normalizing the determinant by `r^2` has the coefficient-core limit.
-/
theorem twoPointZeroSkeletonDet_div_rsq_tendsto (d : ℝ) (hd : 0 < d) :
    Tendsto (fun r : ℝ ↦ twoPointZeroSkeletonDet d r / r ^ 2) (𝓝[>] 0)
      (𝓝 (16 * (1 - Real.exp (-2 * d)))) := by
  have hEventual :
      (fun r : ℝ ↦ twoPointZeroSkeletonDet d r / r ^ 2) =ᶠ[𝓝[>] 0]
        (fun r : ℝ ↦ twoPointCoefficientCore d r) := by
    filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < d / 2 by nlinarith)] with r hr
    have hr₀ : 0 < r := hr.1
    have hgap : 2 * r < d := by nlinarith [hr.2]
    have hrne : r ≠ 0 := ne_of_gt hr₀
    rw [twoPointZeroSkeletonDet_eq hr₀ hgap]
    simp [twoPointCoefficientCore]
    field_simp [hrne]
  exact Tendsto.congr' hEventual.symm (twoPointCoefficientCore_tendsto d hd)

/-- The source zero-skeleton determinant limit is not the conjectured coefficient `16`. -/
theorem twoPointZeroSkeletonDet_div_rsq_not_tendsto_conjectured (d : ℝ) (hd : 0 < d) :
    ¬ Tendsto (fun r : ℝ ↦ twoPointZeroSkeletonDet d r / r ^ 2) (𝓝[>] 0)
      (𝓝 (16 : ℝ)) := by
  intro h
  have hEq :
      (16 * (1 - Real.exp (-2 * d))) = 16 :=
    tendsto_nhds_unique (twoPointZeroSkeletonDet_div_rsq_tendsto d hd) h
  have hlt : 16 * (1 - Real.exp (-2 * d)) < 16 := by
    have hpos : 0 < Real.exp (-2 * d) := Real.exp_pos (-2 * d)
    nlinarith
  linarith

/-- Positive adjacent gaps encode an ordered finite skew source set in one dimension. -/
def finiteGapSkew {m : ℕ} (gaps : Fin m → ℝ) : Prop :=
  ∀ i, 0 < gaps i

/-- Small-radius condition corresponding to disjoint cubical projections between adjacent cubes. -/
def finiteGapSmallRadius {m : ℕ} (gaps : Fin m → ℝ) (r : ℝ) : Prop :=
  0 < r ∧ ∀ i, 2 * r < gaps i

/-- The ordered source point obtained by summing all adjacent gaps before index `i`. -/
noncomputable def finiteGapSourcePoint {m : ℕ} (gaps : Fin m → ℝ)
    (i : Fin (m + 1)) : ℝ :=
  ∑ j : Fin m, if (j : ℕ) < (i : ℕ) then gaps j else 0

lemma finiteGapSourcePoint_succ {m : ℕ} (gaps : Fin m → ℝ) (i : Fin m) :
    finiteGapSourcePoint gaps i.succ =
      finiteGapSourcePoint gaps i.castSucc + gaps i := by
  calc
    finiteGapSourcePoint gaps i.succ =
        ∑ j : Fin m, ((if j = i then gaps j else 0) +
          if (j : ℕ) < (i : ℕ) then gaps j else 0) := by
      rw [finiteGapSourcePoint]
      apply Finset.sum_congr rfl
      intro j _hj
      by_cases hji : j = i
      · subst j
        simp
      · have hlt_succ_iff : ((j : ℕ) < (i : ℕ) + 1) ↔ (j : ℕ) < (i : ℕ) := by
          constructor
          · intro hlt
            have hne : (j : ℕ) ≠ (i : ℕ) := by
              intro hval
              exact hji (Fin.ext hval)
            omega
          · intro hlt
            omega
        simp [Fin.val_succ, hji, hlt_succ_iff]
    _ = (∑ j : Fin m, if j = i then gaps j else 0) +
        ∑ j : Fin m, if (j : ℕ) < (i : ℕ) then gaps j else 0 := by
      rw [Finset.sum_add_distrib]
    _ = finiteGapSourcePoint gaps i.castSucc + gaps i := by
      simp [finiteGapSourcePoint, add_comm]

/-- The left/right offset inside a one-dimensional cubical thickening. -/
def finiteGapVertexOffset (r : ℝ) (s : Fin 2) : ℝ :=
  if (s : ℕ) = 0 then -r else r

/--
The zero-skeleton vertices of an arbitrary ordered finite one-dimensional source
after cubical thickening by radius `r`.
-/
noncomputable def finiteGapThickeningVertex {m : ℕ} (gaps : Fin m → ℝ) (r : ℝ)
    (v : Fin (m + 1) × Fin 2) : ℝ :=
  finiteGapSourcePoint gaps v.1 + finiteGapVertexOffset r v.2

/-- The source-geometry similarity matrix for an arbitrary ordered finite thickening. -/
noncomputable def finiteGapZeroSkeletonSimilarity {m : ℕ} (gaps : Fin m → ℝ)
    (r : ℝ) : Matrix (Fin (m + 1) × Fin 2) (Fin (m + 1) × Fin 2) ℝ :=
  fun i j ↦ Real.exp (-|finiteGapThickeningVertex gaps r i -
    finiteGapThickeningVertex gaps r j|)

/-- The determinant object attached to the arbitrary finite thickening zero-skeleton. -/
noncomputable def finiteGapZeroSkeletonDet {m : ℕ} (gaps : Fin m → ℝ) (r : ℝ) : ℝ :=
  (finiteGapZeroSkeletonSimilarity gaps r).det

/--
The ordered-line equivalence for the finite-gap zero skeleton.  The pair
`(i,s)` is sent to the line position `s + 2*i`, matching the paper's
left/right zero-skeleton ordering of each cubical thickening.
-/
noncomputable def finiteGapPairToOrderedEquiv (m : ℕ) :
    Fin (m + 1) × Fin 2 ≃ Fin ((2 * m + 1) + 1) :=
  finProdFinEquiv.trans (finCongr (by omega : (m + 1) * 2 = (2 * m + 1) + 1))

/-- The source zero-skeleton similarity matrix reindexed by the ordered line. -/
noncomputable def finiteGapOrderedZeroSkeletonSimilarity {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) :
    Matrix (Fin ((2 * m + 1) + 1)) (Fin ((2 * m + 1) + 1)) ℝ :=
  (finiteGapZeroSkeletonSimilarity gaps r).submatrix
    (finiteGapPairToOrderedEquiv m).symm
    (finiteGapPairToOrderedEquiv m).symm

/-- The ordered zero-skeleton vertex sequence induced by the pair-to-line reindex. -/
noncomputable def finiteGapOrderedVertex {m : ℕ} (gaps : Fin m → ℝ) (r : ℝ)
    (i : Fin ((2 * m + 1) + 1)) : ℝ :=
  finiteGapThickeningVertex gaps r ((finiteGapPairToOrderedEquiv m).symm i)

lemma finiteGapOrderedZeroSkeletonSimilarity_apply {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (i j : Fin ((2 * m + 1) + 1)) :
    finiteGapOrderedZeroSkeletonSimilarity gaps r i j =
      Real.exp (-|finiteGapOrderedVertex gaps r i - finiteGapOrderedVertex gaps r j|) := by
  rfl

/-- Reindexing the pair-indexed source matrix along the ordered line preserves determinant. -/
lemma finiteGapOrderedZeroSkeletonSimilarity_det {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) :
    (finiteGapOrderedZeroSkeletonSimilarity gaps r).det =
      finiteGapZeroSkeletonDet gaps r := by
  simp [finiteGapOrderedZeroSkeletonSimilarity, finiteGapZeroSkeletonDet]

/--
The KMS-style determinant product predicted by the ordered zero-skeleton gap
factorization: short within-cube gaps contribute `m+1` factors, and each adjacent
source gap contributes one middle factor.
-/
noncomputable def finiteGapDeterminantProductCore {m : ℕ} (gaps : Fin m → ℝ)
    (r : ℝ) : ℝ :=
  (1 - Real.exp (-4 * r)) ^ (m + 1) *
    ∏ i, (1 - Real.exp (-2 * (gaps i - 2 * r)))

/--
Product-index equivalence separating the `m+1` short within-cube factors from
the `m` middle source-gap factors.  The equivalence is only for the commutative
determinant product split; the ordered source matrix still uses
`finiteGapPairToOrderedEquiv`.
-/
noncomputable def finiteGapProductSplitIndexEquiv (m : ℕ) :
    Fin (m + 1) ⊕ Fin m ≃ Fin (2 * m + 1) :=
  finSumFinEquiv.trans (finCongr (by omega : (m + 1) + m = 2 * m + 1))

/-- The two factor classes in the finite-gap KMS determinant product. -/
noncomputable def finiteGapDeterminantProductSplitFactor {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) : Fin (m + 1) ⊕ Fin m → ℝ
  | Sum.inl _ => 1 - Real.exp (-4 * r)
  | Sum.inr i => 1 - Real.exp (-2 * (gaps i - 2 * r))

/-- The split short/middle product is exactly `finiteGapDeterminantProductCore`. -/
lemma finiteGapDeterminantProductCore_sumFactors {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) :
    (∏ i : Fin (m + 1) ⊕ Fin m,
      finiteGapDeterminantProductSplitFactor gaps r i) =
      finiteGapDeterminantProductCore gaps r := by
  rw [Fintype.prod_sum_type]
  simp [finiteGapDeterminantProductSplitFactor, finiteGapDeterminantProductCore]

/--
Product split for an ordered KMS factor vector once its factors are matched to
the short/middle finite-gap classes.
-/
theorem finiteGapDeterminantProductCore_of_splitFactors {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (q : Fin (2 * m + 1) → ℝ)
    (h :
      ∀ i : Fin (m + 1) ⊕ Fin m,
        1 - q (finiteGapProductSplitIndexEquiv m i) ^ 2 =
          finiteGapDeterminantProductSplitFactor gaps r i) :
    (∏ i : Fin (2 * m + 1), (1 - q i ^ 2)) =
      finiteGapDeterminantProductCore gaps r := by
  calc
    (∏ i : Fin (2 * m + 1), (1 - q i ^ 2)) =
        ∏ i : Fin (m + 1) ⊕ Fin m,
          (1 - q (finiteGapProductSplitIndexEquiv m i) ^ 2) := by
      rw [← Equiv.prod_comp (finiteGapProductSplitIndexEquiv m)
        (fun i : Fin (2 * m + 1) ↦ 1 - q i ^ 2)]
    _ =
        ∏ i : Fin (m + 1) ⊕ Fin m,
          finiteGapDeterminantProductSplitFactor gaps r i := by
      apply Finset.prod_congr rfl
      intro i _hi
      exact h i
    _ = finiteGapDeterminantProductCore gaps r :=
      finiteGapDeterminantProductCore_sumFactors gaps r

/--
Alternating product-index equivalence for the concrete adjacent source factors:
short within-cube factors live at even adjacent positions, and middle source-gap
factors live at odd adjacent positions.
-/
def finiteGapAlternatingProductSplitIndex {m : ℕ} :
    Fin (m + 1) ⊕ Fin m → Fin (2 * m + 1)
  | Sum.inl i => ⟨2 * (i : ℕ), by omega⟩
  | Sum.inr i => ⟨2 * (i : ℕ) + 1, by omega⟩

lemma finiteGapAlternatingProductSplitIndex_injective {m : ℕ} :
    Function.Injective (finiteGapAlternatingProductSplitIndex (m := m)) := by
  intro a b h
  cases a with
  | inl ai =>
      cases b with
      | inl bi =>
          simp [finiteGapAlternatingProductSplitIndex] at h
          apply congrArg Sum.inl
          exact Fin.ext (by omega)
      | inr bj =>
          simp [finiteGapAlternatingProductSplitIndex] at h
          omega
  | inr ai =>
      cases b with
      | inl bj =>
          simp [finiteGapAlternatingProductSplitIndex] at h
          omega
      | inr bj =>
          simp [finiteGapAlternatingProductSplitIndex] at h
          apply congrArg Sum.inr
          exact Fin.ext (by omega)

/-- The alternating even/odd split of the adjacent product positions. -/
noncomputable def finiteGapAlternatingProductSplitIndexEquiv (m : ℕ) :
    Fin (m + 1) ⊕ Fin m ≃ Fin (2 * m + 1) :=
  Equiv.ofBijective (finiteGapAlternatingProductSplitIndex (m := m)) (by
    rw [Fintype.bijective_iff_injective_and_card]
    constructor
    · exact finiteGapAlternatingProductSplitIndex_injective
    · simpa using (by omega : (m + 1) + m = 2 * m + 1))

lemma finiteGapAlternatingProductSplitIndexEquiv_apply {m : ℕ}
    (i : Fin (m + 1) ⊕ Fin m) :
    finiteGapAlternatingProductSplitIndexEquiv m i =
      finiteGapAlternatingProductSplitIndex i := by
  rfl

/--
Product split for an ordered KMS factor vector whose factors are matched to the
alternating even/odd finite-gap classes.
-/
theorem finiteGapDeterminantProductCore_of_alternatingSplitFactors {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (q : Fin (2 * m + 1) → ℝ)
    (h :
      ∀ i : Fin (m + 1) ⊕ Fin m,
        1 - q (finiteGapAlternatingProductSplitIndexEquiv m i) ^ 2 =
          finiteGapDeterminantProductSplitFactor gaps r i) :
    (∏ i : Fin (2 * m + 1), (1 - q i ^ 2)) =
      finiteGapDeterminantProductCore gaps r := by
  calc
    (∏ i : Fin (2 * m + 1), (1 - q i ^ 2)) =
        ∏ i : Fin (m + 1) ⊕ Fin m,
          (1 - q (finiteGapAlternatingProductSplitIndexEquiv m i) ^ 2) := by
      rw [← Equiv.prod_comp (finiteGapAlternatingProductSplitIndexEquiv m)
        (fun i : Fin (2 * m + 1) ↦ 1 - q i ^ 2)]
    _ =
        ∏ i : Fin (m + 1) ⊕ Fin m,
          finiteGapDeterminantProductSplitFactor gaps r i := by
      apply Finset.prod_congr rfl
      intro i _hi
      exact h i
    _ = finiteGapDeterminantProductCore gaps r :=
      finiteGapDeterminantProductCore_sumFactors gaps r

/--
Boundary predicate for the remaining arbitrary finite-F algebra: the source
geometry determinant equals the KMS-style product for small positive `r`.
-/
def finiteGapDeterminantProductLaw {m : ℕ} (gaps : Fin m → ℝ) : Prop :=
  ∀ᶠ r in 𝓝[>] 0, finiteGapZeroSkeletonDet gaps r = finiteGapDeterminantProductCore gaps r

/-- Natural-number access to an adjacent KMS factor, defaulting to `1` outside range. -/
noncomputable def orderedKMSQNat {n : ℕ} (q : Fin n → ℝ) (k : ℕ) : ℝ :=
  if h : k < n then q ⟨k, h⟩ else 1

/-- Prefix product of adjacent KMS factors before index `i`. -/
noncomputable def orderedKMSPrefix {n : ℕ} (q : Fin n → ℝ) (i : Fin (n + 1)) : ℝ :=
  Finset.prod (Finset.range (i : ℕ)) (fun k ↦ orderedKMSQNat q k)

lemma orderedKMSPrefix_zero {n : ℕ} (q : Fin n → ℝ) :
    orderedKMSPrefix q (0 : Fin (n + 1)) = 1 := by
  simp [orderedKMSPrefix]

lemma orderedKMSPrefix_succ {n : ℕ} (q : Fin n → ℝ) (i : Fin n) :
    orderedKMSPrefix q i.succ = orderedKMSPrefix q i.castSucc * q i := by
  simp [orderedKMSPrefix, orderedKMSQNat, Finset.prod_range_succ,
    Nat.lt_of_lt_of_le i.isLt (Nat.le_refl n)]

lemma orderedKMSQNat_ne_zero {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0) (k : ℕ) :
    orderedKMSQNat q k ≠ 0 := by
  unfold orderedKMSQNat
  split_ifs with hk
  · exact hq ⟨k, hk⟩
  · norm_num

lemma orderedKMSPrefix_ne_zero {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0)
    (i : Fin (n + 1)) : orderedKMSPrefix q i ≠ 0 := by
  rw [orderedKMSPrefix, Finset.prod_ne_zero_iff]
  intro k _hk
  exact orderedKMSQNat_ne_zero hq k

/--
The ordered one-dimensional KMS/exponential-kernel matrix determined by adjacent
factors `q`. The entry is the product of adjacent factors between two ordered
indices, expressed through prefix products.
-/
noncomputable def orderedKMS {n : ℕ} (q : Fin n → ℝ) :
    Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ :=
  fun i j ↦ if (i : ℕ) ≤ (j : ℕ) then orderedKMSPrefix q j / orderedKMSPrefix q i
    else orderedKMSPrefix q i / orderedKMSPrefix q j

/-- Adjacent exponential factors for a finite ordered line. -/
noncomputable def orderedAdjacentExpFactors {n : ℕ} (x : Fin (n + 1) → ℝ) :
    Fin n → ℝ :=
  fun i ↦ Real.exp (-(x i.succ - x i.castSucc))

lemma orderedAdjacentExpFactors_ne_zero {n : ℕ} (x : Fin (n + 1) → ℝ) :
    ∀ i, orderedAdjacentExpFactors x i ≠ 0 := by
  intro i
  exact Real.exp_ne_zero _

lemma orderedKMSPrefix_orderedAdjacentExpFactors {n : ℕ} (x : Fin (n + 1) → ℝ)
    (i : Fin (n + 1)) :
    orderedKMSPrefix (orderedAdjacentExpFactors x) i = Real.exp (-(x i - x 0)) := by
  induction i using Fin.induction with
  | zero =>
      simp [orderedKMSPrefix_zero]
  | succ i ih =>
      rw [orderedKMSPrefix_succ, ih]
      simp [orderedAdjacentExpFactors, ← Real.exp_add]

/--
For any monotone ordered line, the KMS matrix built from adjacent exponential
factors is the exponential-distance kernel on that line.
-/
theorem orderedKMS_orderedAdjacentExpFactors_eq_exp_abs {n : ℕ}
    (x : Fin (n + 1) → ℝ) (hmono : ∀ ⦃i j : Fin (n + 1)⦄, i ≤ j → x i ≤ x j) :
    orderedKMS (orderedAdjacentExpFactors x) =
      fun i j ↦ Real.exp (-|x i - x j|) := by
  ext i j
  by_cases hij : i ≤ j
  · have hxij : x i ≤ x j := hmono hij
    have habs : |x i - x j| = x j - x i := by
      calc
        |x i - x j| = -(x i - x j) := abs_of_nonpos (by linarith)
        _ = x j - x i := by ring
    simp [orderedKMS, hij, orderedKMSPrefix_orderedAdjacentExpFactors,
      habs, div_eq_mul_inv, ← Real.exp_neg, ← Real.exp_add]
  · have hji : j ≤ i := le_of_not_ge hij
    have hxji : x j ≤ x i := hmono hji
    have habs : |x i - x j| = x i - x j := by
      exact abs_of_nonneg (by linarith)
    simp [orderedKMS, hij, orderedKMSPrefix_orderedAdjacentExpFactors,
      habs, div_eq_mul_inv, ← Real.exp_neg, ← Real.exp_add]

/--
The concrete adjacent source factor map for the ordered finite-gap
zero-skeleton.  It is the alternating adjacent line factor map induced by the
ordered left/right zero-skeleton vertices.
-/
noncomputable def finiteGapAlternatingAdjacentSourceFactor {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) : Fin (2 * m + 1) → ℝ :=
  orderedAdjacentExpFactors (finiteGapOrderedVertex gaps r)

lemma finiteGapAlternatingAdjacentSourceFactor_ne_zero {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) :
    ∀ i, finiteGapAlternatingAdjacentSourceFactor gaps r i ≠ 0 :=
  orderedAdjacentExpFactors_ne_zero (finiteGapOrderedVertex gaps r)

/--
Even adjacent positions in the ordered zero-skeleton are the within-cube
left/right gaps, hence have adjacent factor `exp (-2*r)`.
-/
lemma finiteGapAlternatingAdjacentSourceFactor_even {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (i : Fin (m + 1)) :
    finiteGapAlternatingAdjacentSourceFactor gaps r
      (finiteGapAlternatingProductSplitIndex (Sum.inl i)) =
      Real.exp (-2 * r) := by
  let k : Fin (2 * m + 1) := finiteGapAlternatingProductSplitIndex (Sum.inl i)
  let e := finiteGapPairToOrderedEquiv m
  have hleft : e.symm k.castSucc = (i, 0) := by
    apply e.injective
    apply Fin.ext
    simp [e, finiteGapPairToOrderedEquiv, k, finiteGapAlternatingProductSplitIndex]
  have hright : e.symm k.succ = (i, 1) := by
    apply e.injective
    apply Fin.ext
    simp [e, finiteGapPairToOrderedEquiv, k, finiteGapAlternatingProductSplitIndex]
    omega
  simp [finiteGapAlternatingAdjacentSourceFactor, orderedAdjacentExpFactors,
    finiteGapOrderedVertex, e, k, hleft, hright, finiteGapThickeningVertex,
    finiteGapVertexOffset]
  ring_nf

/--
Odd adjacent positions in the ordered zero-skeleton are the middle source gaps,
shortened by the two radius offsets.
-/
lemma finiteGapAlternatingAdjacentSourceFactor_odd {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (i : Fin m) :
    finiteGapAlternatingAdjacentSourceFactor gaps r
      (finiteGapAlternatingProductSplitIndex (Sum.inr i)) =
      Real.exp (-(gaps i - 2 * r)) := by
  let k : Fin (2 * m + 1) := finiteGapAlternatingProductSplitIndex (Sum.inr i)
  let e := finiteGapPairToOrderedEquiv m
  have hleft : e.symm k.castSucc = (i.castSucc, 1) := by
    apply e.injective
    apply Fin.ext
    simp [e, finiteGapPairToOrderedEquiv, k, finiteGapAlternatingProductSplitIndex]
    omega
  have hright : e.symm k.succ = (i.succ, 0) := by
    apply e.injective
    apply Fin.ext
    simp [e, finiteGapPairToOrderedEquiv, k, finiteGapAlternatingProductSplitIndex]
    omega
  have hsource := finiteGapSourcePoint_succ gaps i
  simp [finiteGapAlternatingAdjacentSourceFactor, orderedAdjacentExpFactors,
    finiteGapOrderedVertex, e, k, hleft, hright, finiteGapThickeningVertex,
    finiteGapVertexOffset, hsource]
  ring_nf

/--
Concrete product-transfer theorem for the alternating adjacent source factor
map: its KMS determinant product is exactly the finite-gap product core.
-/
theorem finiteGapAlternatingAdjacentSourceFactor_productCore {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) :
    (∏ i : Fin (2 * m + 1),
      (1 - finiteGapAlternatingAdjacentSourceFactor gaps r i ^ 2)) =
      finiteGapDeterminantProductCore gaps r := by
  apply finiteGapDeterminantProductCore_of_alternatingSplitFactors
  intro i
  cases i with
  | inl short =>
      rw [finiteGapAlternatingProductSplitIndexEquiv_apply,
        finiteGapAlternatingAdjacentSourceFactor_even]
      have hsq : Real.exp (-(2 * r)) ^ 2 = Real.exp (-(4 * r)) := by
        rw [sq, ← Real.exp_add]
        ring_nf
      simp [finiteGapDeterminantProductSplitFactor, hsq]
  | inr middle =>
      rw [finiteGapAlternatingProductSplitIndexEquiv_apply,
        finiteGapAlternatingAdjacentSourceFactor_odd]
      have hsq :
          Real.exp (2 * r - gaps middle) ^ 2 =
            Real.exp (-2 * (gaps middle - 2 * r)) := by
        rw [sq, ← Real.exp_add]
        ring_nf
      simp [finiteGapDeterminantProductSplitFactor, hsq]

/--
The source zero-skeleton matrix is the ordered KMS matrix for the concrete
adjacent source factors once the ordered zero-skeleton vertices are monotone.
-/
theorem finiteGapOrderedZeroSkeletonSimilarity_eq_orderedKMS_of_monotone {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ)
    (hmono : ∀ ⦃i j : Fin ((2 * m + 1) + 1)⦄, i ≤ j →
      finiteGapOrderedVertex gaps r i ≤ finiteGapOrderedVertex gaps r j) :
    finiteGapOrderedZeroSkeletonSimilarity gaps r =
      orderedKMS (finiteGapAlternatingAdjacentSourceFactor gaps r) := by
  change finiteGapOrderedZeroSkeletonSimilarity gaps r =
    orderedKMS (orderedAdjacentExpFactors (finiteGapOrderedVertex gaps r))
  rw [orderedKMS_orderedAdjacentExpFactors_eq_exp_abs
    (finiteGapOrderedVertex gaps r) hmono]
  ext i j
  simp [finiteGapOrderedZeroSkeletonSimilarity_apply]

/--
It is enough to check nonnegativity of consecutive ordered zero-skeleton
steps to identify the source matrix with the concrete adjacent-factor KMS
matrix.
-/
theorem finiteGapOrderedZeroSkeletonSimilarity_eq_orderedKMS_of_adjacent_nonneg {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ)
    (hadj : ∀ k : Fin (2 * m + 1),
      finiteGapOrderedVertex gaps r k.castSucc ≤ finiteGapOrderedVertex gaps r k.succ) :
    finiteGapOrderedZeroSkeletonSimilarity gaps r =
      orderedKMS (finiteGapAlternatingAdjacentSourceFactor gaps r) := by
  apply finiteGapOrderedZeroSkeletonSimilarity_eq_orderedKMS_of_monotone
  intro i j hij
  exact (Fin.monotone_iff_le_succ.2 hadj) hij

lemma finiteGapOrderedVertex_adjacent_nonneg_of_smallRadius {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (hsmall : finiteGapSmallRadius gaps r)
    (k : Fin (2 * m + 1)) :
    finiteGapOrderedVertex gaps r k.castSucc ≤ finiteGapOrderedVertex gaps r k.succ := by
  rcases hsmall with ⟨hrpos, hgap⟩
  let e := finiteGapPairToOrderedEquiv m
  by_cases hk : (k : ℕ) % 2 = 0
  · let a : Fin (m + 1) := ⟨(k : ℕ) / 2, by omega⟩
    have hleft : e.symm k.castSucc = (a, 0) := by
      apply e.injective
      apply Fin.ext
      simp [e, finiteGapPairToOrderedEquiv, a, hk]
    have hright : e.symm k.succ = (a, 1) := by
      apply e.injective
      apply Fin.ext
      simp [e, finiteGapPairToOrderedEquiv, a]
      omega
    simp [finiteGapOrderedVertex, e, hleft, hright, finiteGapThickeningVertex,
      finiteGapVertexOffset]
    linarith
  · have hkone : (k : ℕ) % 2 = 1 := by omega
    let a : Fin m := ⟨(k : ℕ) / 2, by omega⟩
    have hleft : e.symm k.castSucc = (a.castSucc, 1) := by
      apply e.injective
      apply Fin.ext
      simp [e, finiteGapPairToOrderedEquiv, a, hkone]
    have hright : e.symm k.succ = (a.succ, 0) := by
      apply e.injective
      apply Fin.ext
      simp [e, finiteGapPairToOrderedEquiv, a]
      omega
    have hsource := finiteGapSourcePoint_succ gaps a
    have hgap_a := hgap a
    simp [finiteGapOrderedVertex, e, hleft, hright, finiteGapThickeningVertex,
      finiteGapVertexOffset, hsource]
    linarith

/--
Under the finite-gap small-radius condition, the ordered source zero-skeleton
matrix is exactly the ordered KMS matrix for the concrete alternating adjacent
source factors.
-/
theorem finiteGapOrderedZeroSkeletonSimilarity_eq_orderedKMS_of_smallRadius {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (hsmall : finiteGapSmallRadius gaps r) :
    finiteGapOrderedZeroSkeletonSimilarity gaps r =
      orderedKMS (finiteGapAlternatingAdjacentSourceFactor gaps r) := by
  apply finiteGapOrderedZeroSkeletonSimilarity_eq_orderedKMS_of_adjacent_nonneg
  intro k
  exact finiteGapOrderedVertex_adjacent_nonneg_of_smallRadius gaps r hsmall k

/--
Small-radius determinant bridge for the concrete alternating adjacent source
factors.
-/
theorem finiteGapZeroSkeletonDet_eq_orderedKMS_of_smallRadius {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (hsmall : finiteGapSmallRadius gaps r) :
    finiteGapZeroSkeletonDet gaps r =
      (orderedKMS (finiteGapAlternatingAdjacentSourceFactor gaps r)).det := by
  rw [← finiteGapOrderedZeroSkeletonSimilarity_det gaps r,
    finiteGapOrderedZeroSkeletonSimilarity_eq_orderedKMS_of_smallRadius gaps r hsmall]

/--
If the ordered reindexing of the source zero-skeleton matrix is the ordered KMS
matrix, then the original pair-indexed source determinant is the ordered KMS
determinant.
-/
theorem finiteGapZeroSkeletonDet_eq_orderedKMS_of_ordered_similarity_eq {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (q : Fin (2 * m + 1) → ℝ)
    (h :
      finiteGapOrderedZeroSkeletonSimilarity gaps r =
        orderedKMS q) :
    finiteGapZeroSkeletonDet gaps r = (orderedKMS q).det := by
  rw [← finiteGapOrderedZeroSkeletonSimilarity_det gaps r, h]

/-- The matrix after descending row operations `Rᵢ₊₁ ← Rᵢ₊₁ - qᵢ Rᵢ`. -/
noncomputable def orderedKMSRowReduced {n : ℕ} (q : Fin n → ℝ) :
    Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ :=
  fun i j ↦ Fin.cases (orderedKMS q 0 j)
    (fun p ↦ orderedKMS q p.succ j - q p * orderedKMS q p.castSucc j) i

lemma orderedKMSRowReduced_zero {n : ℕ} (q : Fin n → ℝ) (j : Fin (n + 1)) :
    orderedKMSRowReduced q 0 j = orderedKMS q 0 j := by
  simp [orderedKMSRowReduced]

lemma orderedKMSRowReduced_succ {n : ℕ} (q : Fin n → ℝ) (i : Fin n)
    (j : Fin (n + 1)) :
    orderedKMSRowReduced q i.succ j =
      orderedKMS q i.succ j - q i * orderedKMS q i.castSucc j := by
  simp [orderedKMSRowReduced]

lemma orderedKMS_self {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0)
    (i : Fin (n + 1)) :
    orderedKMS q i i = 1 := by
  simp [orderedKMS, orderedKMSPrefix_ne_zero hq i]

lemma orderedKMS_succ_castSucc {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0)
    (i : Fin n) :
    orderedKMS q i.castSucc i.succ = q i := by
  have hp : orderedKMSPrefix q i.succ = orderedKMSPrefix q i.castSucc * q i :=
    orderedKMSPrefix_succ q i
  have hne : orderedKMSPrefix q i.castSucc ≠ 0 := orderedKMSPrefix_ne_zero hq i.castSucc
  simp [orderedKMS, Fin.val_castSucc, Fin.val_succ, hp, hne]

lemma orderedKMSRowReduced_diag_zero {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0) :
    orderedKMSRowReduced q 0 0 = 1 := by
  simp [orderedKMSRowReduced_zero, orderedKMS_self hq]

lemma orderedKMSRowReduced_diag_succ {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0)
    (i : Fin n) :
    orderedKMSRowReduced q i.succ i.succ = 1 - q i ^ 2 := by
  rw [orderedKMSRowReduced_succ, orderedKMS_self hq, orderedKMS_succ_castSucc hq]
  ring

lemma orderedKMSRowReduced_below {n : ℕ} {q : Fin n → ℝ} (hq : ∀ i, q i ≠ 0)
    {i j : Fin (n + 1)} (hij : j < i) :
    orderedKMSRowReduced q i j = 0 := by
  induction i using Fin.cases with
  | zero =>
      exact (not_lt_of_ge (Fin.zero_le j) hij).elim
  | succ p =>
      rw [orderedKMSRowReduced_succ]
      have hjp : (j : ℕ) ≤ (p : ℕ) := by
        exact Nat.lt_succ_iff.mp hij
      have hsucc_not : ¬ (p.succ : Fin (n + 1)) ≤ j := not_le_of_gt hij
      have hpj_or : (p : ℕ) ≤ (j : ℕ) ∨ (j : ℕ) < (p : ℕ) := le_or_gt _ _
      have hpref : orderedKMSPrefix q p.succ = orderedKMSPrefix q p.castSucc * q p :=
        orderedKMSPrefix_succ q p
      have hjne : orderedKMSPrefix q j ≠ 0 := orderedKMSPrefix_ne_zero hq j
      have hpne : orderedKMSPrefix q p.castSucc ≠ 0 :=
        orderedKMSPrefix_ne_zero hq p.castSucc
      rcases hpj_or with hpj | hjltp
      · have hval : (j : ℕ) = (p : ℕ) := le_antisymm hjp hpj
        have hji : j = p.castSucc := Fin.ext hval
        subst j
        simp [orderedKMS, hpref, hpne]
      · simp [orderedKMS, not_lt_of_ge hjp, not_le_of_gt hjltp, hpref]
        ring_nf

/-- General ordered KMS determinant product for arbitrary nonzero adjacent factors. -/
lemma orderedKMS_det {n : ℕ} (q : Fin n → ℝ) (hq : ∀ i, q i ≠ 0) :
    (orderedKMS q).det = ∏ i, (1 - q i ^ 2) := by
  let A := orderedKMS q
  let B := orderedKMSRowReduced q
  have hdet : A.det = B.det := by
    apply Matrix.det_eq_of_forall_row_eq_smul_add_pred (c := q)
    · intro j
      simp [A, B, orderedKMSRowReduced_zero]
    · intro i j
      simp [A, B, orderedKMSRowReduced_succ]
  have htri : B.BlockTriangular id := by
    intro i j hij
    simpa [B] using orderedKMSRowReduced_below hq hij
  calc
    A.det = B.det := hdet
    _ = ∏ i : Fin (n + 1), B i i := by
      rw [Matrix.det_of_upperTriangular htri]
    _ = ∏ i, (1 - q i ^ 2) := by
      rw [Fin.prod_univ_succ]
      simp [B, orderedKMSRowReduced_diag_zero hq, orderedKMSRowReduced_diag_succ hq]

/--
Concrete single-radius finite-gap determinant product theorem: under the
small-radius condition that orders the source zero-skeleton, the determinant is
the product core associated to the alternating adjacent source factors.
-/
theorem finiteGapZeroSkeletonDet_eq_productCore_of_smallRadius {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (hsmall : finiteGapSmallRadius gaps r) :
    finiteGapZeroSkeletonDet gaps r = finiteGapDeterminantProductCore gaps r := by
  rw [finiteGapZeroSkeletonDet_eq_orderedKMS_of_smallRadius gaps r hsmall,
    orderedKMS_det (finiteGapAlternatingAdjacentSourceFactor gaps r)
      (finiteGapAlternatingAdjacentSourceFactor_ne_zero gaps r),
    finiteGapAlternatingAdjacentSourceFactor_productCore gaps r]

/--
Positive finite gaps imply the small-radius source-ordering condition eventually
as `r -> 0+`.
-/
theorem finiteGapSmallRadius_eventually_of_skew {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) :
    ∀ᶠ r in 𝓝[>] 0, finiteGapSmallRadius gaps r := by
  have hgap :
      ∀ᶠ r in 𝓝[>] 0, ∀ i : Fin m, 2 * r < gaps i := by
    exact eventually_all.mpr fun i => by
      filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < gaps i / 2 by
        nlinarith [hskew i])] with r hr
      nlinarith [hr.2]
  filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < 1 by norm_num), hgap] with r hr hgap_r
  exact ⟨hr.1, hgap_r⟩

/--
For every ordered one-dimensional finite skew source encoded by adjacent
positive gaps, the source zero-skeleton determinant has the finite-gap product
law eventually as `r -> 0+`.
-/
theorem finiteGapDeterminantProductLaw_of_skew {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) :
    finiteGapDeterminantProductLaw gaps := by
  filter_upwards [finiteGapSmallRadius_eventually_of_skew gaps hskew] with r hsmall
  exact finiteGapZeroSkeletonDet_eq_productCore_of_smallRadius gaps r hsmall

/--
Conditional discharge of the finite-gap determinant-product law from an ordered
KMS factorization of the source zero-skeleton determinant.
-/
theorem finiteGapDeterminantProductLaw_of_orderedKMSBridge {m n : ℕ}
    (gaps : Fin m → ℝ) (q : ℝ → Fin n → ℝ)
    (hq : ∀ᶠ r in 𝓝[>] 0, ∀ i, q r i ≠ 0)
    (hdet : ∀ᶠ r in 𝓝[>] 0,
      finiteGapZeroSkeletonDet gaps r = (orderedKMS (q r)).det)
    (hcore : ∀ᶠ r in 𝓝[>] 0,
      (∏ i, (1 - q r i ^ 2)) = finiteGapDeterminantProductCore gaps r) :
    finiteGapDeterminantProductLaw gaps := by
  filter_upwards [hq, hdet, hcore] with r hq_r hdet_r hcore_r
  rw [hdet_r, orderedKMS_det (q r) hq_r, hcore_r]

/--
Single-radius finite-gap source-to-product bridge: ordered source-matrix
identification plus the short/middle product split discharge the determinant
product core.
-/
theorem finiteGapZeroSkeletonDet_eq_productCore_of_orderedKMS_source_split {m : ℕ}
    (gaps : Fin m → ℝ) (r : ℝ) (q : Fin (2 * m + 1) → ℝ)
    (hq : ∀ i, q i ≠ 0)
    (hsource :
      finiteGapOrderedZeroSkeletonSimilarity gaps r =
        orderedKMS q)
    (hsplit :
      ∀ i : Fin (m + 1) ⊕ Fin m,
        1 - q (finiteGapProductSplitIndexEquiv m i) ^ 2 =
          finiteGapDeterminantProductSplitFactor gaps r i) :
    finiteGapZeroSkeletonDet gaps r = finiteGapDeterminantProductCore gaps r := by
  rw [finiteGapZeroSkeletonDet_eq_orderedKMS_of_ordered_similarity_eq gaps r q hsource,
    orderedKMS_det q hq,
    finiteGapDeterminantProductCore_of_splitFactors gaps r q hsplit]

/--
Eventual finite-gap determinant-product law from the two concrete bridge
obligations: ordered source-matrix equality and short/middle product split.
-/
theorem finiteGapDeterminantProductLaw_of_orderedKMSSourceMatrixBridge {m : ℕ}
    (gaps : Fin m → ℝ) (q : ℝ → Fin (2 * m + 1) → ℝ)
    (hq : ∀ᶠ r in 𝓝[>] 0, ∀ i, q r i ≠ 0)
    (hsource : ∀ᶠ r in 𝓝[>] 0,
      finiteGapOrderedZeroSkeletonSimilarity gaps r =
        orderedKMS (q r))
    (hsplit : ∀ᶠ r in 𝓝[>] 0,
      ∀ i : Fin (m + 1) ⊕ Fin m,
        1 - q r (finiteGapProductSplitIndexEquiv m i) ^ 2 =
          finiteGapDeterminantProductSplitFactor gaps r i) :
    finiteGapDeterminantProductLaw gaps := by
  filter_upwards [hq, hsource, hsplit] with r hq_r hsource_r hsplit_r
  exact finiteGapZeroSkeletonDet_eq_productCore_of_orderedKMS_source_split
    gaps r (q r) hq_r hsource_r hsplit_r

/--
Paper-level boundary: the universal `ell_1^N` skew finite-F determinant
coefficient asserted by the source conjecture is already false in the
one-dimensional two-point skew case.
-/
theorem paperLevel_ellOne_twoPoint_conjecturedCoefficient_fails (d : ℝ) (hd : 0 < d) :
    ¬ Tendsto (fun r : ℝ ↦ twoPointZeroSkeletonDet d r / r ^ 2) (𝓝[>] 0)
      (𝓝 (16 : ℝ)) :=
  twoPointZeroSkeletonDet_div_rsq_not_tendsto_conjectured d hd

/--
The source paper's `N = 1` specialization of the conjectured coefficient.
For an ordered finite-gap source with `m + 1` points, the source formula has
`k = 2^(1-1) * 1 * |F| = m + 1`, hence conjectured coefficient `4^(m+1)`.
-/
noncomputable def paperLevelEllOneFiniteGapConjecturedCoefficient (m : ℕ) : ℝ :=
  (4 : ℝ) ^ (m + 1)

/--
The actual coefficient forced by the one-dimensional finite-gap determinant
product: the source coefficient `4^(m+1)` multiplied by the middle-gap
attenuation product.
-/
noncomputable def finiteGapActualCoefficient {m : ℕ} (gaps : Fin m → ℝ) : ℝ :=
  (4 : ℝ) ^ (m + 1) * ∏ i, (1 - Real.exp (-2 * gaps i))

/--
The normalized coefficient core for an arbitrary ordered finite one-dimensional
source set, represented by its positive adjacent gaps. If the general KMS
determinant product is supplied for the ordered zero-skeleton, this is the
coefficient limit forced by that determinant product.
-/
noncomputable def finiteGapCoefficientCore {m : ℕ} (gaps : Fin m → ℝ) (r : ℝ) : ℝ :=
  ((1 - Real.exp (-4 * r)) / r) ^ (m + 1) *
    ∏ i, (1 - Real.exp (-2 * (gaps i - 2 * r)))

/--
For an arbitrary finite list of adjacent gaps, the determinant-product coefficient
core tends to `4^(m+1)` times the middle-gap attenuation product.
-/
theorem finiteGapCoefficientCore_tendsto {m : ℕ} (gaps : Fin m → ℝ) :
    Tendsto (fun r : ℝ ↦ finiteGapCoefficientCore gaps r) (𝓝[>] 0)
      (𝓝 (finiteGapActualCoefficient gaps)) := by
  have hFirst := tendsto_one_sub_exp_neg4_div
  have hPow : Tendsto (fun r : ℝ ↦ ((1 - Real.exp (-4 * r)) / r) ^ (m + 1))
      (𝓝[>] 0) (𝓝 ((4 : ℝ) ^ (m + 1))) :=
    hFirst.pow (m + 1)
  have hMiddle :
      Tendsto (fun r : ℝ ↦ ∏ i, (1 - Real.exp (-2 * (gaps i - 2 * r))))
        (𝓝[>] 0) (𝓝 (∏ i, (1 - Real.exp (-2 * gaps i)))) := by
    refine tendsto_finset_prod Finset.univ ?_
    intro i _hi
    have hCont : Continuous fun r : ℝ ↦ 1 - Real.exp (-2 * (gaps i - 2 * r)) := by
      continuity
    have hWithin :
        ContinuousWithinAt (fun r : ℝ ↦ 1 - Real.exp (-2 * (gaps i - 2 * r)))
          (Set.Ioi 0) 0 :=
      hCont.continuousAt.continuousWithinAt
    simpa using hWithin.tendsto
  simpa [finiteGapCoefficientCore, finiteGapActualCoefficient] using hPow.mul hMiddle

/--
The determinant normalized by the source exponent `m+1` has the actual
finite-gap coefficient limit for every ordered one-dimensional finite skew
source.
-/
theorem finiteGapZeroSkeletonDet_normalized_tendsto_actualCoefficient_of_skew {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) :
    Tendsto (fun r : ℝ ↦ finiteGapZeroSkeletonDet gaps r / r ^ (m + 1)) (𝓝[>] 0)
      (𝓝 (finiteGapActualCoefficient gaps)) := by
  have hEventual :
      (fun r : ℝ ↦ finiteGapZeroSkeletonDet gaps r / r ^ (m + 1)) =ᶠ[𝓝[>] 0]
        (fun r : ℝ ↦ finiteGapCoefficientCore gaps r) := by
    filter_upwards [finiteGapSmallRadius_eventually_of_skew gaps hskew] with r hsmall
    have hsmall' := hsmall
    rcases hsmall with ⟨hrpos, _hgap⟩
    have hrne : r ≠ 0 := ne_of_gt hrpos
    rw [finiteGapZeroSkeletonDet_eq_productCore_of_smallRadius gaps r hsmall']
    rw [finiteGapDeterminantProductCore, finiteGapCoefficientCore]
    rw [div_pow]
    field_simp [pow_ne_zero (m + 1) hrne]
  exact Tendsto.congr' hEventual.symm (finiteGapCoefficientCore_tendsto gaps)

/--
Conditional arbitrary finite-gap obstruction: once the ordered zero-skeleton
determinant has the KMS product shape, any middle-gap attenuation product
different from `1` rules out the source coefficient `4^(m+1)`.
-/
theorem finiteGapCoefficientCore_not_tendsto_source_coefficient {m : ℕ}
    (gaps : Fin m → ℝ)
    (hprod : (∏ i, (1 - Real.exp (-2 * gaps i))) ≠ 1) :
    ¬ Tendsto (fun r : ℝ ↦ finiteGapCoefficientCore gaps r) (𝓝[>] 0)
      (𝓝 (paperLevelEllOneFiniteGapConjecturedCoefficient m)) := by
  intro h
  have hEq :
      finiteGapActualCoefficient gaps =
        paperLevelEllOneFiniteGapConjecturedCoefficient m :=
    tendsto_nhds_unique (finiteGapCoefficientCore_tendsto gaps) h
  have h4ne : (4 : ℝ) ^ (m + 1) ≠ 0 := pow_ne_zero _ (by norm_num)
  have hEqProd : (∏ i, (1 - Real.exp (-2 * gaps i))) = 1 := by
    have hEq' :
        (4 : ℝ) ^ (m + 1) * (∏ i, (1 - Real.exp (-2 * gaps i))) =
          (4 : ℝ) ^ (m + 1) * 1 := by
      simpa [finiteGapActualCoefficient, paperLevelEllOneFiniteGapConjecturedCoefficient]
        using hEq
    exact mul_left_cancel₀ h4ne hEq'
  exact hprod hEqProd

/--
Source-boundary obstruction for the normalized determinant itself: in the
one-dimensional finite-gap specialization, if the middle-gap attenuation product
is not `1`, the determinant cannot have the paper source coefficient `4^(m+1)`.
-/
theorem finiteGapZeroSkeletonDet_normalized_not_tendsto_source_coefficient_of_skew {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps)
    (hprod : (∏ i, (1 - Real.exp (-2 * gaps i))) ≠ 1) :
    ¬ Tendsto (fun r : ℝ ↦ finiteGapZeroSkeletonDet gaps r / r ^ (m + 1)) (𝓝[>] 0)
      (𝓝 (paperLevelEllOneFiniteGapConjecturedCoefficient m)) := by
  intro h
  have hEq :
      finiteGapActualCoefficient gaps =
        paperLevelEllOneFiniteGapConjecturedCoefficient m :=
    tendsto_nhds_unique
      (finiteGapZeroSkeletonDet_normalized_tendsto_actualCoefficient_of_skew gaps hskew) h
  have h4ne : (4 : ℝ) ^ (m + 1) ≠ 0 := pow_ne_zero _ (by norm_num)
  have hEqProd : (∏ i, (1 - Real.exp (-2 * gaps i))) = 1 := by
    have hEq' :
        (4 : ℝ) ^ (m + 1) * (∏ i, (1 - Real.exp (-2 * gaps i))) =
          (4 : ℝ) ^ (m + 1) * 1 := by
      simpa [finiteGapActualCoefficient, paperLevelEllOneFiniteGapConjecturedCoefficient]
        using hEq
    exact mul_left_cancel₀ h4ne hEq'
  exact hprod hEqProd

/-- Each middle-gap attenuation factor is positive for a positive source gap. -/
lemma finiteGapMiddleAttenuationFactor_pos {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) (i : Fin m) :
    0 < 1 - Real.exp (-2 * gaps i) := by
  have hneg : -2 * gaps i < 0 := by
    nlinarith [hskew i]
  have hexp_lt : Real.exp (-2 * gaps i) < 1 := by
    exact Real.exp_lt_one_iff.mpr hneg
  linarith

/-- Each middle-gap attenuation factor is strictly below `1`. -/
lemma finiteGapMiddleAttenuationFactor_lt_one {m : ℕ}
    (gaps : Fin m → ℝ) (i : Fin m) :
    1 - Real.exp (-2 * gaps i) < 1 := by
  have hpos : 0 < Real.exp (-2 * gaps i) := Real.exp_pos _
  linarith

/--
For any nonempty ordered finite one-dimensional skew source, the product of the
middle-gap attenuation factors is strictly less than `1`.
-/
theorem finiteGapMiddleAttenuationProduct_lt_one_of_skew_nonempty {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) (hm : 0 < m) :
    (∏ i, (1 - Real.exp (-2 * gaps i))) < 1 := by
  classical
  let s : Finset (Fin m) := Finset.univ
  have hpos : ∀ i ∈ s, 0 < 1 - Real.exp (-2 * gaps i) := by
    intro i _hi
    exact finiteGapMiddleAttenuationFactor_pos gaps hskew i
  have hlt : ∀ i ∈ s, 1 - Real.exp (-2 * gaps i) < (1 : ℝ) := by
    intro i _hi
    exact finiteGapMiddleAttenuationFactor_lt_one gaps i
  have hs : s.Nonempty := ⟨⟨0, hm⟩, Finset.mem_univ _⟩
  simpa [s] using
    (Finset.prod_lt_prod_of_nonempty
      (s := s)
      (f := fun i : Fin m ↦ 1 - Real.exp (-2 * gaps i))
      (g := fun _ : Fin m ↦ (1 : ℝ))
      hpos hlt hs)

/--
For any nonempty ordered finite one-dimensional skew source, the middle-gap
attenuation product cannot equal `1`.
-/
theorem finiteGapMiddleAttenuationProduct_ne_one_of_skew_nonempty {m : ℕ}
    (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) (hm : 0 < m) :
    (∏ i, (1 - Real.exp (-2 * gaps i))) ≠ 1 :=
  ne_of_lt (finiteGapMiddleAttenuationProduct_lt_one_of_skew_nonempty gaps hskew hm)

/--
Full one-dimensional finite-gap source-coefficient failure: every ordered
finite skew source with at least two points violates the source-paper
coefficient `4^(m+1)` after cubical thickening.
-/
theorem finiteGapZeroSkeletonDet_normalized_not_tendsto_source_coefficient_of_skew_nonempty
    {m : ℕ} (gaps : Fin m → ℝ) (hskew : finiteGapSkew gaps) (hm : 0 < m) :
    ¬ Tendsto (fun r : ℝ ↦ finiteGapZeroSkeletonDet gaps r / r ^ (m + 1)) (𝓝[>] 0)
      (𝓝 (paperLevelEllOneFiniteGapConjecturedCoefficient m)) :=
  finiteGapZeroSkeletonDet_normalized_not_tendsto_source_coefficient_of_skew
    gaps hskew (finiteGapMiddleAttenuationProduct_ne_one_of_skew_nonempty gaps hskew hm)

end MagnitudeGeneralizationBoundary
