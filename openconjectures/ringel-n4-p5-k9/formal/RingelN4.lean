import Std

namespace RingelN4P5K9
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 9).flatMap (fun i => (List.range (8-i)).map (fun k => (i,i+k+1)))
def copies : List (List Nat) :=
  [[0,1,3,6,2],[1,2,4,7,3],[2,3,5,8,4],[3,4,6,0,5],
   [4,5,7,1,6],[5,6,8,2,7],[6,7,0,3,8],[7,8,1,4,0],[8,0,2,5,1]]
def pathEdges : List Nat → List Edge
  | a :: b :: rest => edge a b :: pathEdges (b :: rest)
  | _ => []
def usedEdges : List Edge := (copies.map pathEdges).flatten
def validPath (p : List Nat) : Bool := p.length = 5 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validPath p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN4P5K9
