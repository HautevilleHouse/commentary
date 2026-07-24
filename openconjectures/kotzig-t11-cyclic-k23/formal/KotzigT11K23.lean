import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT11K23
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon ((i + 11) % 23) ((i + 20) % 23), canon ((i + 20) % 23) ((i + 21) % 23),
   canon ((i + 21) % 23) (i % 23), canon (i % 23) ((i + 1) % 23),
   canon ((i + 1) % 23) ((i + 3) % 23), canon ((i + 3) % 23) ((i + 6) % 23),
   canon ((i + 6) % 23) ((i + 10) % 23), canon ((i + 10) % 23) ((i + 15) % 23),
   canon ((i + 15) % 23) ((i + 9) % 23), canon ((i + 9) % 23) ((i + 16) % 23),
   canon ((i + 16) % 23) ((i + 8) % 23)}
def family : Finset Edge := (List.range 23).foldl (fun acc i => acc ∪ tree i) ∅
def k23Edges : Finset Edge := ((Finset.range 23).product (Finset.range 23)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k23Edges := by native_decide
end KotzigT11K23
