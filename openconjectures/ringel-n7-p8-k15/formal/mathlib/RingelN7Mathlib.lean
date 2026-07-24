import Mathlib.Data.Fin.Basic

namespace RingelN7P8K15Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 15).flatMap (fun i => (List.range (14-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,7,1,6,2,5,3,4],[1,8,2,7,3,6,4,5],[2,9,3,8,4,7,5,6],[3,10,4,9,5,8,6,7],
   [4,11,5,10,6,9,7,8],[5,12,6,11,7,10,8,9],[6,13,7,12,8,11,9,10],
   [7,14,8,13,9,12,10,11],[8,0,9,14,10,13,11,12],[9,1,10,0,11,14,12,13],
   [10,2,11,1,12,0,13,14],[11,3,12,2,13,1,14,0],[12,4,13,3,14,2,0,1],
   [13,5,14,4,0,3,1,2],[14,6,0,5,1,4,2,3]]
def pathEdges : List Nat → List Edge
  | a :: b :: rest => edge a b :: pathEdges (b :: rest)
  | _ => []
def usedEdges : List Edge := (copies.map pathEdges).flatten
def validPath (p : List Nat) : Bool := p.length = 8 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validPath p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN7P8K15Mathlib
