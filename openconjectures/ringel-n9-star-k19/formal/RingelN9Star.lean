import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace RingelN9Star
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def star (i : Nat) : Finset Edge :=
  (List.range 9).foldl (fun acc d => acc.insert (canon (i % 19) ((i + d + 1) % 19))) ∅
def family : Finset Edge := (List.range 19).foldl (fun acc i => acc ∪ star i) ∅
def k19Edges : Finset Edge := ((Finset.range 19).product (Finset.range 19)).filter (fun e => e.1 < e.2)
theorem cyclic_star_partition : family = k19Edges := by native_decide
end RingelN9Star
