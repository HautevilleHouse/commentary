import Mathlib.Data.Fin.Basic

namespace RingelN5P6K11Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 11).flatMap (fun i => (List.range (10-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,5,1,4,2,3],[1,6,2,5,3,4],[2,7,3,6,4,5],[3,8,4,7,5,6],
   [4,9,5,8,6,7],[5,10,6,9,7,8],[6,0,7,10,8,9],[7,1,8,0,9,10],
   [8,2,9,1,10,0],[9,3,10,2,0,1],[10,4,0,3,1,2]]
def pathEdges : List Nat → List Edge
  | a :: b :: rest => edge a b :: pathEdges (b :: rest)
  | _ => []
def usedEdges : List Edge := (copies.map pathEdges).flatten
def validPath (p : List Nat) : Bool := p.length = 6 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validPath p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN5P6K11Mathlib
