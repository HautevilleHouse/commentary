import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT5K11
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon (i % 11) ((i + 1) % 11), canon (i % 11) ((i + 2) % 11),
   canon (i % 11) ((i + 3) % 11), canon ((i + 3) % 11) ((i + 10) % 11),
   canon ((i + 10) % 11) ((i + 4) % 11)}
def family : Finset Edge := (List.range 11).foldl (fun acc i => acc ∪ tree i) ∅
def k11Edges : Finset Edge := ((Finset.range 11).product (Finset.range 11)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k11Edges := by native_decide
end KotzigT5K11
