import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range

namespace RingelN8Star
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def star (i : Nat) : Finset Edge :=
  (List.range 8).foldl (fun acc d => acc.insert (canon (i % 17) ((i + d + 1) % 17))) ∅
def family : Finset Edge := (List.range 17).foldl (fun acc i => acc ∪ star i) ∅
def k17Edges : Finset Edge :=
  ((Finset.range 17).product (Finset.range 17)).filter (fun e => e.1 < e.2)
theorem cyclic_star_partition : family = k17Edges := by native_decide
end RingelN8Star
