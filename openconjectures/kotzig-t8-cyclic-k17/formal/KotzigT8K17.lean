import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT8K17
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon (i % 17) ((i + 1) % 17), canon (i % 17) ((i + 2) % 17), canon (i % 17) ((i + 3) % 17),
   canon ((i + 3) % 17) ((i + 7) % 17), canon ((i + 7) % 17) ((i + 12) % 17),
   canon ((i + 12) % 17) ((i + 6) % 17), canon ((i + 6) % 17) ((i + 13) % 17),
   canon ((i + 13) % 17) ((i + 4) % 17)}
def family : Finset Edge := (List.range 17).foldl (fun acc i => acc ∪ tree i) ∅
def k17Edges : Finset Edge := ((Finset.range 17).product (Finset.range 17)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k17Edges := by native_decide
end KotzigT8K17
