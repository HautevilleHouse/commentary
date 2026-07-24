set_option maxRecDepth 1000000

namespace RingelN9Star

abbrev Edge := Nat × Nat
def edge (a b : Nat) : Edge := if a ≤ b then (a, b) else (b, a)

def allEdges : List Edge :=
  (List.range 19).flatMap (fun i => (List.range (18 - i)).map (fun k => (i, i + k + 1)))

def copies : List (List Nat) :=
  (List.range 19).map (fun c => c :: (List.range 9).map (fun k => (c + k + 1) % 19))

def starEdges : List Nat → List Edge
  | c :: rest => rest.map (edge c)
  | _ => []

def usedEdges : List Edge := (copies.map starEdges).flatten

def validStar (p : List Nat) : Bool := p.length = 10 && p.Nodup

theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validStar p = true := by decide
theorem cyclic_star_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide

end RingelN9Star
