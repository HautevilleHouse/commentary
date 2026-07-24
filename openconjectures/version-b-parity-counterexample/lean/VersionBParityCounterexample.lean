namespace VersionBParityCounterexample

abbrev Position := List Nat

def target : Position := [5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6]
def child : Position := [4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5]

def removeAll (p : Position) : Position :=
  (p.map (fun n => n - 1)).filter (fun n => n > 0)

def oddCount (p : Position) : Nat :=
  (p.filter (fun n => n % 2 == 1)).length

def printedKZeroModFourClause (k odd : Nat) : Bool :=
  ((odd % 2 == 0) && decide (odd ≤ k / 2 - 2)) ||
  ((odd % 2 == 1) && decide (k / 2 + 1 ≤ odd) && decide (odd ≤ k - 1))

theorem target_length : target.length = 12 := by decide

theorem target_exceeds_threshold : ∀ n ∈ target, 4 < n := by decide

theorem target_odd_count : oddCount target = 7 := by decide

theorem source_predicts_target_P : printedKZeroModFourClause 12 7 = true := by
  decide

theorem target_all_option : removeAll target = child := by decide

/--
The formal bridge used by the finite certificate: once the separate exact
replay supplies that `child` is a P-position, the legal all-piles move proves
that `target` is not a P-position.
-/
theorem target_not_P_of_child_P
    (IsP : Position → Prop)
    (moveToP : ∀ p q, removeAll p = q → IsP q → ¬ IsP p)
    (childP : IsP child) : ¬ IsP target := by
  exact moveToP target child target_all_option childP

end VersionBParityCounterexample
