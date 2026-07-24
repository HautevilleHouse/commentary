import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range

namespace RingelN7Star

abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)

def star (i : Nat) : Finset Edge :=
  (List.range 7).foldl (fun acc d => acc.insert (canon (i % 15) ((i + d + 1) % 15))) ∅

def family : Finset Edge :=
  (List.range 15).foldl (fun acc i => acc ∪ star i) ∅

def k15Edges : Finset Edge :=
  ((Finset.range 15).product (Finset.range 15)).filter (fun e => e.1 < e.2)

theorem cyclic_star_partition : family = k15Edges := by
  native_decide

end RingelN7Star
