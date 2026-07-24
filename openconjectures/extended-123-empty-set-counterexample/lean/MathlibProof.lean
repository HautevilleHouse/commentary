namespace Extended123EmptySetMathlib

def dilation (m : Nat) (a : List Nat) : List Nat := a.map (fun x => m * x)
def symdiff (a b : List Nat) : List Nat :=
  (a.filter (fun x => x ∉ b)) ++ (b.filter (fun x => x ∉ a))
def displayedLeft (n : Nat) : List Nat :=
  (List.range n).foldl (fun acc m => symdiff acc (dilation (m + 1) [])) []

theorem empty_dilations : ∀ m : Nat, dilation m [] = [] := by
  intro m
  rfl

theorem fold_empty : ∀ xs : List Nat,
    List.foldl (fun acc m => symdiff acc (dilation (m + 1) [])) [] xs = [] := by
  intro xs
  induction xs with
  | nil => rfl
  | cons m xs ih => simpa [dilation, symdiff] using ih

theorem displayed_left_is_empty : ∀ n : Nat, displayedLeft n = [] := by
  intro n
  exact fold_empty (List.range n)

theorem displayed_claim_fails_at_n1 : ¬ (displayedLeft 1).length ≥ 1 := by
  decide

end Extended123EmptySetMathlib
