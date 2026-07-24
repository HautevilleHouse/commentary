set_option maxRecDepth 1000000
namespace RingelN3StarK7Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 7).flatMap (fun i => (List.range (6-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,1,2,4],[1,2,3,5],[2,3,4,6],[3,4,5,0],[4,5,6,1],[5,6,0,2],[6,0,1,3]]
def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []
def usedEdges : List Edge := (copies.map starEdges).flatten
def validStar (p : List Nat) : Bool := p.length = 4 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN3StarK7Mathlib
