set_option maxRecDepth 1000000

namespace RingelN7Star

abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a, b) else (b, a)

def allEdges : List Edge :=
  (List.range 15).flatMap (fun i => (List.range (14 - i)).map (fun k => (i, i + k + 1)))

def copies : List (List Nat) :=
  (List.range 15).map (fun c => c :: (List.range 7).map (fun k => (c + k + 1) % 15))

def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []

def usedEdges : List Edge := (copies.map starEdges).flatten

def validStar (p : List Nat) : Bool := p.length = 8 && p.Nodup

theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by decide
theorem cyclic_star_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide

end RingelN7Star
