import Mathlib.Data.Fin.Basic

namespace RingelN6P7K13Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 13).flatMap (fun i => (List.range (12-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,6,1,5,2,4,3],[1,7,2,6,3,5,4],[2,8,3,7,4,6,5],[3,9,4,8,5,7,6],
   [4,10,5,9,6,8,7],[5,11,6,10,7,9,8],[6,12,7,11,8,10,9],[7,0,8,12,9,11,10],
   [8,1,9,0,10,12,11],[9,2,10,1,11,0,12],[10,3,11,2,12,1,0],[11,4,12,3,0,2,1],[12,5,0,4,1,3,2]]
def pathEdges : List Nat → List Edge
  | a :: b :: rest => edge a b :: pathEdges (b :: rest)
  | _ => []
def usedEdges : List Edge := (copies.map pathEdges).flatten
def validPath (p : List Nat) : Bool := p.length = 7 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validPath p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN6P7K13Mathlib
