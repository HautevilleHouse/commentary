import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT4K9
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon (i % 9) ((i + 1) % 9), canon (i % 9) ((i + 2) % 9),
   canon (i % 9) ((i + 3) % 9), canon ((i + 3) % 9) ((i + 7) % 9)}
def family : Finset Edge := (List.range 9).foldl (fun acc i => acc ∪ tree i) ∅
def k9Edges : Finset Edge := ((Finset.range 9).product (Finset.range 9)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k9Edges := by native_decide
end KotzigT4K9
