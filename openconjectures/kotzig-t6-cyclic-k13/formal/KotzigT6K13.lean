import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT6K13
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon ((i + 2) % 13) ((i + 3) % 13), canon ((i + 2) % 13) ((i + 4) % 13),
   canon ((i + 2) % 13) ((i + 5) % 13), canon ((i + 5) % 13) ((i + 1) % 13),
   canon ((i + 1) % 13) ((i + 6) % 13), canon ((i + 6) % 13) (i % 13)}
def family : Finset Edge := (List.range 13).foldl (fun acc i => acc ∪ tree i) ∅
def k13Edges : Finset Edge := ((Finset.range 13).product (Finset.range 13)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k13Edges := by native_decide
end KotzigT6K13
