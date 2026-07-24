namespace GoemansCounterexampleMathlib

def capacityGood : Fin 8 → Bool
  | 0 => true | 1 => true | 2 => true | 3 => false
  | 4 => true | 5 => false | 6 => false | 7 => false

def cost : Fin 8 → Nat
  | 0 => 90 | 1 => 60 | 2 => 60 | 3 => 30
  | 4 => 60 | 5 => 30 | 6 => 30 | 7 => 0

def feasible (i : Fin 8) : Bool := capacityGood i && (cost i ≤ 58)

theorem no_feasible_routing : ∀ i : Fin 8, feasible i = false := by decide

theorem capacity_good_costs :
    ∀ i : Fin 8, capacityGood i = true → 60 ≤ cost i := by decide

theorem cost_at_most_fractional_violates_capacity :
    ∀ i : Fin 8, cost i ≤ 58 → capacityGood i = false := by decide

end GoemansCounterexampleMathlib
