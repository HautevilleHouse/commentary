import Mathlib.Data.Finset.Basic
import Mathlib.Tactic.NormNum

namespace SLCGMaximumGeneratorCounterexample

def slcgStep (n x : ℕ) : ℕ :=
  (2 * x + 1) % (2 ^ n + 1)

def n7Cycle : Finset ℕ :=
  {42, 85}

def predictedMaximum (n : ℕ) : ℕ :=
  4 * (4 ^ ((n - 3) / 2) - 1) / 3

theorem n7_cycle_arithmetic :
    slcgStep 7 42 = 85 ∧ slcgStep 7 85 = 42 := by
  norm_num [slcgStep]

theorem fortyTwo_is_the_cycle_minimum :
    42 ∈ n7Cycle ∧ ∀ x ∈ n7Cycle, 42 ≤ x := by
  simp [n7Cycle]

theorem printed_formula_at_seven :
    predictedMaximum 7 = 20 := by
  norm_num [predictedMaximum]

theorem source_exact_counterexample :
    slcgStep 7 42 = 85 ∧
    slcgStep 7 85 = 42 ∧
    (42 ∈ n7Cycle ∧ ∀ x ∈ n7Cycle, 42 ≤ x) ∧
    predictedMaximum 7 = 20 ∧
    predictedMaximum 7 < 42 := by
  norm_num [slcgStep, n7Cycle, predictedMaximum]

end SLCGMaximumGeneratorCounterexample
