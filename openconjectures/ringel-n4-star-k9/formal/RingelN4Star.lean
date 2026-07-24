import Std

namespace RingelN4StarK9
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 9).flatMap (fun i => (List.range (8-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,1,2,3,4],[1,2,3,4,5],[2,3,4,5,6],[3,4,5,6,7],[4,5,6,7,8],
   [5,6,7,8,0],[6,7,8,0,1],[7,8,0,1,2],[8,0,1,2,3]]
def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []
def usedEdges : List Edge := (copies.map starEdges).flatten
def validStar (p : List Nat) : Bool := p.length = 5 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN4StarK9
