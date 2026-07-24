import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace NineArithmeticFunctionInequalities

noncomputable section

def symmetricProduct (x y z : ℝ) : ℝ :=
  (x + y + z) * (1 / x + 1 / y + 1 / z)

def cyclicRatio (x y z : ℝ) : ℝ :=
  x / (y + z) + y / (x + z) + z / (x + y)

def leftQ (u v : ℝ) : ℝ :=
  2 * u * v ^ 2 + u * v - 2 * u ^ 3 + 2 * u ^ 2 - u - v - 1

def rightQ (s t : ℝ) : ℝ :=
  t ^ 3 + t ^ 2 * s + t ^ 2 - t * s - 2 * t - 2 * s ^ 2 + 2

theorem symmetricProduct_left_step_identity
    {u v : ℝ} (hu : u ≠ 0) (hv : v ≠ 0) :
    symmetricProduct 1 u v - symmetricProduct 1 u u =
      (u + 1) * (v - u) * (v - 1) / (u * v) := by
  unfold symmetricProduct
  field_simp [hu, hv]
  ring

theorem symmetricProduct_left_base_identity
    {r u : ℝ} (hr : r ≠ 0) (hu : u ≠ 0) :
    symmetricProduct 1 u u - symmetricProduct 1 r r =
      2 * (u - r) * (r * u - 1) / (r * u) := by
  unfold symmetricProduct
  field_simp [hr, hu]
  ring

theorem cyclicRatio_left_step_identity
    {u v : ℝ} (hu : u ≠ 0) (hu1 : u + 1 ≠ 0)
    (huv : u + v ≠ 0) (hv1 : v + 1 ≠ 0) :
    cyclicRatio 1 u v - cyclicRatio 1 u u =
      (v - u) * leftQ u v / (2 * u * (u + 1) * (u + v) * (v + 1)) := by
  have h1u : 1 + u ≠ 0 := by simpa [add_comm] using hu1
  have h1v : 1 + v ≠ 0 := by simpa [add_comm] using hv1
  unfold cyclicRatio leftQ
  field_simp [hu, h1u, h1v, huv]
  ring

theorem cyclicRatio_left_base_identity
    {r u : ℝ} (hr : r ≠ 0) (hu : u ≠ 0)
    (hr1 : r + 1 ≠ 0) (hu1 : u + 1 ≠ 0) :
    cyclicRatio 1 u u - cyclicRatio 1 r r =
      (u - r) * (3 * r * u - r - u - 1) /
        (2 * r * u * (r + 1) * (u + 1)) := by
  have h1r : 1 + r ≠ 0 := by simpa [add_comm] using hr1
  have h1u : 1 + u ≠ 0 := by simpa [add_comm] using hu1
  unfold cyclicRatio
  field_simp [hr, hu, h1r, h1u]
  ring

theorem leftQ_nonnegative {u v : ℝ} (hu : 1 ≤ u) (huv : u ≤ v) :
    0 ≤ leftQ u v := by
  have hu0 : 0 ≤ u := by linarith
  have hu1 : 0 ≤ u - 1 := by linarith
  have hd : 0 ≤ v - u := by linarith
  have hdecomp :
      leftQ u v =
        2 * (v - u) ^ 2 * u +
        4 * (v - u) * u ^ 2 +
        (v - u) * (u - 1) +
        (3 * u + 1) * (u - 1) := by
    simp only [leftQ]
    ring
  rw [hdecomp]
  positivity

theorem ordered_left_symmetricProduct
    {r u v : ℝ} (hr : 1 ≤ r) (hru : r ≤ u) (huv : u ≤ v) :
    symmetricProduct 1 r r ≤ symmetricProduct 1 u v := by
  have hr0 : 0 < r := by linarith
  have hu0 : 0 < u := by linarith
  have hv0 : 0 < v := by linarith
  have hstep : symmetricProduct 1 u u ≤ symmetricProduct 1 u v := by
    apply sub_nonneg.mp
    rw [symmetricProduct_left_step_identity hu0.ne' hv0.ne']
    apply div_nonneg
    · exact mul_nonneg (mul_nonneg (by linarith) (by linarith)) (by linarith)
    · exact mul_nonneg hu0.le hv0.le
  have hbase : symmetricProduct 1 r r ≤ symmetricProduct 1 u u := by
    apply sub_nonneg.mp
    rw [symmetricProduct_left_base_identity hr0.ne' hu0.ne']
    have hru0 : 0 ≤ u - r := by linarith
    have hprod : 1 ≤ r * u := by nlinarith
    apply div_nonneg
    · exact mul_nonneg (mul_nonneg (by linarith) hru0) (by linarith)
    · exact mul_nonneg hr0.le hu0.le
  exact hbase.trans hstep

theorem ordered_left_cyclicRatio
    {r u v : ℝ} (hr : 1 ≤ r) (hru : r ≤ u) (huv : u ≤ v) :
    cyclicRatio 1 r r ≤ cyclicRatio 1 u v := by
  have hr0 : 0 < r := by linarith
  have hu0 : 0 < u := by linarith
  have hv0 : 0 < v := by linarith
  have hu1 : 0 < u + 1 := by linarith
  have hv1 : 0 < v + 1 := by linarith
  have huv0 : 0 < u + v := by linarith
  have hstep : cyclicRatio 1 u u ≤ cyclicRatio 1 u v := by
    apply sub_nonneg.mp
    rw [cyclicRatio_left_step_identity hu0.ne' hu1.ne' huv0.ne' hv1.ne']
    have hq := leftQ_nonnegative (u := u) (v := v) (by linarith) huv
    apply div_nonneg
    · exact mul_nonneg (by linarith) hq
    · positivity
  have hbase : cyclicRatio 1 r r ≤ cyclicRatio 1 u u := by
    apply sub_nonneg.mp
    rw [cyclicRatio_left_base_identity hr0.ne' hu0.ne'
      (by linarith : r + 1 ≠ 0) (by linarith : u + 1 ≠ 0)]
    have hfactor : 0 ≤ 3 * r * u - r - u - 1 := by
      have hidentity :
          3 * r * u - r - u - 1 =
            (r - 1) * (u - 1) + 2 * (r * u - 1) := by ring
      rw [hidentity]
      have hprod : 1 ≤ r * u := by nlinarith
      have hmul : 0 ≤ (r - 1) * (u - 1) :=
        mul_nonneg (by linarith) (by linarith)
      nlinarith
    apply div_nonneg
    · exact mul_nonneg (by linarith) hfactor
    · positivity
  exact hbase.trans hstep

theorem symmetricProduct_right_step_identity
    {s t : ℝ} (hs : s ≠ 0) (ht : t ≠ 0) :
    symmetricProduct s 1 t - symmetricProduct 1 1 t =
      (t - s) * (t + 1) * (1 - s) / (t * s) := by
  unfold symmetricProduct
  field_simp [hs, ht]
  ring

theorem symmetricProduct_right_base_identity
    {r t : ℝ} (hr : r ≠ 0) (ht : t ≠ 0) :
    symmetricProduct 1 1 t - symmetricProduct 1 1 r =
      2 * (t - r) * (r * t - 1) / (r * t) := by
  unfold symmetricProduct
  field_simp [hr, ht]
  ring

theorem cyclicRatio_right_step_identity
    {s t : ℝ} (ht1 : t + 1 ≠ 0) (hts : t + s ≠ 0)
    (hs1 : s + 1 ≠ 0) :
    cyclicRatio s 1 t - cyclicRatio 1 1 t =
      (1 - s) * rightQ s t / (2 * (t + 1) * (t + s) * (s + 1)) := by
  have h1t : 1 + t ≠ 0 := by simpa [add_comm] using ht1
  have hst : s + t ≠ 0 := by simpa [add_comm] using hts
  have h1s : 1 + s ≠ 0 := by simpa [add_comm] using hs1
  unfold cyclicRatio rightQ
  field_simp [h1t, hst, h1s]
  ring

theorem cyclicRatio_right_base_identity
    {r t : ℝ} (hr1 : r + 1 ≠ 0) (ht1 : t + 1 ≠ 0) :
    cyclicRatio 1 1 t - cyclicRatio 1 1 r =
      (t - r) * (r * t + r + t - 3) / (2 * (r + 1) * (t + 1)) := by
  have h1r : 1 + r ≠ 0 := by simpa [add_comm] using hr1
  have h1t : 1 + t ≠ 0 := by simpa [add_comm] using ht1
  unfold cyclicRatio
  field_simp [h1r, h1t]
  ring

theorem rightQ_nonnegative
    {s t : ℝ} (hs0 : 0 ≤ s) (hs1 : s ≤ 1) (ht : 1 ≤ t) :
    0 ≤ rightQ s t := by
  have hd : 0 ≤ t - 1 := by linarith
  have he : 0 ≤ 1 - s := by linarith
  have hdecomp :
      rightQ s t =
        (t - 1) ^ 3 + 4 * (t - 1) ^ 2 + 3 * (t - 1) +
        2 * (1 - s) + s * (t - 1) ^ 2 + s * (t - 1) +
        2 * (1 - s) * s := by
    simp only [rightQ]
    ring
  rw [hdecomp]
  positivity

theorem ordered_right_symmetricProduct
    {s r t : ℝ} (hs : 0 < s) (hs1 : s ≤ 1) (hr : 1 ≤ r) (hrt : r ≤ t) :
    symmetricProduct 1 1 r ≤ symmetricProduct s 1 t := by
  have hr0 : 0 < r := by linarith
  have ht0 : 0 < t := by linarith
  have hstep : symmetricProduct 1 1 t ≤ symmetricProduct s 1 t := by
    apply sub_nonneg.mp
    rw [symmetricProduct_right_step_identity hs.ne' ht0.ne']
    apply div_nonneg
    · exact mul_nonneg (mul_nonneg (by linarith) (by linarith)) (by linarith)
    · exact mul_nonneg ht0.le hs.le
  have hbase : symmetricProduct 1 1 r ≤ symmetricProduct 1 1 t := by
    apply sub_nonneg.mp
    rw [symmetricProduct_right_base_identity hr0.ne' ht0.ne']
    have hprod : 1 ≤ r * t := by nlinarith
    apply div_nonneg
    · exact mul_nonneg (mul_nonneg (by linarith) (by linarith)) (by linarith)
    · exact mul_nonneg hr0.le ht0.le
  exact hbase.trans hstep

theorem ordered_right_cyclicRatio
    {s r t : ℝ} (hs : 0 < s) (hs1 : s ≤ 1) (hr : 1 ≤ r) (hrt : r ≤ t) :
    cyclicRatio 1 1 r ≤ cyclicRatio s 1 t := by
  have ht1 : 0 < t + 1 := by linarith
  have hts : 0 < t + s := by linarith
  have hsone : 0 < s + 1 := by linarith
  have hr1 : 0 < r + 1 := by linarith
  have hstep : cyclicRatio 1 1 t ≤ cyclicRatio s 1 t := by
    apply sub_nonneg.mp
    rw [cyclicRatio_right_step_identity ht1.ne' hts.ne' hsone.ne']
    have hq := rightQ_nonnegative (s := s) (t := t) (by linarith) hs1 (by linarith)
    apply div_nonneg
    · exact mul_nonneg (by linarith) hq
    · positivity
  have hbase : cyclicRatio 1 1 r ≤ cyclicRatio 1 1 t := by
    apply sub_nonneg.mp
    rw [cyclicRatio_right_base_identity hr1.ne' ht1.ne']
    have hfactor : 0 ≤ r * t + r + t - 3 := by
      have hidentity :
          r * t + r + t - 3 =
            (r - 1) * (t - 1) + 2 * (r - 1) + 2 * (t - 1) := by ring
      rw [hidentity]
      have hmul : 0 ≤ (r - 1) * (t - 1) :=
        mul_nonneg (by linarith) (by linarith)
      nlinarith
    apply div_nonneg
    · exact mul_nonneg (by linarith) hfactor
    · positivity
  exact hbase.trans hstep

theorem prime_gap_base_identity (p : ℝ) :
    p * ((p + 1) - (p - 1)) - (p - 1) - (p + 1) = 0 := by
  ring

theorem fresh_prime_gap_step_identity (p m A B C : ℝ) :
    (p * m * ((p + 1) * B - (p - 1) * A) - (p - 1) * A - (p + 1) * C) -
      p ^ 2 * (m * (B - A) - A - C) =
        p * m * (A + B) + (p ^ 2 - p + 1) * A + (p ^ 2 - p - 1) * C := by
  ring

theorem fresh_prime_gap_step_nonnegative
    {p m A B C : ℝ} (hp : 2 ≤ p) (hm : 0 ≤ m)
    (hA : 0 ≤ A) (hB : 0 ≤ B) (hC : 0 ≤ C) :
    0 ≤ p * m * (A + B) + (p ^ 2 - p + 1) * A + (p ^ 2 - p - 1) * C := by
  have hp0 : 0 ≤ p := by linarith
  have hpm : 0 ≤ p * m := mul_nonneg hp0 hm
  have hab : 0 ≤ A + B := add_nonneg hA hB
  have hcoef : 0 ≤ p ^ 2 - p - 1 := by
    have hmul : 0 ≤ (p - 2) * (p + 1) :=
      mul_nonneg (by linarith) (by linarith)
    nlinarith
  have hcoef' : 0 ≤ p ^ 2 - p + 1 := by nlinarith
  exact add_nonneg
    (add_nonneg (mul_nonneg hpm hab) (mul_nonneg hcoef' hA))
    (mul_nonneg hcoef hC)

theorem repeated_prime_gap_step_identity (p m A B C E : ℝ) :
    (p ^ 2 * m * (B - A) - p * A - (p * C + E)) -
      p ^ 2 * (m * (B - A) - A - C) =
        p * (p - 1) * (A + C) - E := by
  ring

theorem repeated_prime_gap_step_nonnegative
    {p A C E : ℝ} (hp : 2 ≤ p) (hA : 0 ≤ A)
    (hE : 0 ≤ E) (hEC : E ≤ C) :
    0 ≤ p * (p - 1) * (A + C) - E := by
  have hC : 0 ≤ C := hE.trans hEC
  have hfactor : 1 ≤ p * (p - 1) := by nlinarith
  have hsum : C ≤ A + C := by linarith
  have hscaled : A + C ≤ p * (p - 1) * (A + C) := by
    have hsum0 : 0 ≤ A + C := by linarith
    have hproduct : 0 ≤ (p * (p - 1) - 1) * (A + C) :=
      mul_nonneg (by linarith) hsum0
    nlinarith
  linarith

end

end NineArithmeticFunctionInequalities
