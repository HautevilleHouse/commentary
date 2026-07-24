import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT9K19
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon (i % 19) ((i + 1) % 19), canon ((i + 1) % 19) ((i + 2) % 19),
   canon ((i + 2) % 19) ((i + 3) % 19), canon ((i + 3) % 19) ((i + 18) % 19),
   canon ((i + 18) % 19) ((i + 13) % 19), canon ((i + 13) % 19) ((i + 7) % 19),
   canon ((i + 7) % 19) ((i + 14) % 19), canon ((i + 14) % 19) ((i + 6) % 19),
   canon ((i + 6) % 19) ((i + 15) % 19)}
def family : Finset Edge := (List.range 19).foldl (fun acc i => acc ∪ tree i) ∅
def k19Edges : Finset Edge := ((Finset.range 19).product (Finset.range 19)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k19Edges := by native_decide
end KotzigT9K19
