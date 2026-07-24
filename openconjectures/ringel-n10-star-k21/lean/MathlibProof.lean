set_option maxRecDepth 1000000

namespace RingelN10StarK21Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 21).flatMap (fun i => (List.range (20-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  (List.range 21).map (fun c => c :: (List.range 10).map (fun k => (c+k+1) % 21))
def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []
def usedEdges : List Edge := (copies.map starEdges).flatten
def validStar (p : List Nat) : Bool := p.length = 11 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN10StarK21Mathlib
