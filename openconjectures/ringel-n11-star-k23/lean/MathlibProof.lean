set_option maxRecDepth 1000000

namespace RingelN11StarK23Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 23).flatMap (fun i => (List.range (22-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  (List.range 23).map (fun c => c :: (List.range 11).map (fun k => (c+k+1) % 23))
def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []
def usedEdges : List Edge := (copies.map starEdges).flatten
def validStar (p : List Nat) : Bool := p.length = 12 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by native_decide
theorem used_edges_nodup : usedEdges.Nodup := by native_decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by native_decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by native_decide
end RingelN11StarK23Mathlib
