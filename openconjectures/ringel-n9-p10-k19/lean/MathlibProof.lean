set_option maxRecDepth 1000000

namespace RingelN9P10K19Mathlib
abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a,b) else (b,a)
def allEdges : List Edge :=
  (List.range 19).flatMap (fun i => (List.range (18-i)).map (fun k => (i,i+k+1)))
def base : List Nat := [0,9,10,18,1,8,11,17,2,7]
def copies : List (List Nat) := (List.range 19).map (fun s => base.map (fun v => (v+s) % 19))
def pathEdges : List Nat → List Edge
  | a :: b :: rest => edge a b :: pathEdges (b :: rest)
  | _ => []
def usedEdges : List Edge := (copies.map pathEdges).flatten
def validPath (p : List Nat) : Bool := p.length = 10 && p.Nodup
theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validPath p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide
end RingelN9P10K19Mathlib
