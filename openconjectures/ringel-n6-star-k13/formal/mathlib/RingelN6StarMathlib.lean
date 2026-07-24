import Mathlib.Data.Fin.Basic

namespace RingelN6StarK13Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 13).flatMap (fun i => (List.range (12-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,1,2,3,4,5,6],[1,2,3,4,5,6,7],[2,3,4,5,6,7,8],[3,4,5,6,7,8,9],
   [4,5,6,7,8,9,10],[5,6,7,8,9,10,11],[6,7,8,9,10,11,12],
   [7,8,9,10,11,12,0],[8,9,10,11,12,0,1],[9,10,11,12,0,1,2],
   [10,11,12,0,1,2,3],[11,12,0,1,2,3,4],[12,0,1,2,3,4,5]]
def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []
def usedEdges : List Edge := (copies.map starEdges).flatten
def validStar (p : List Nat) : Bool := p.length = 7 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN6StarK13Mathlib
