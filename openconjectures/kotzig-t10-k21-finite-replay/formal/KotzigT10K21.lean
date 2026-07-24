import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT10K21
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon (i % 21) ((i + 9) % 21), canon ((i + 9) % 21) ((i + 8) % 21),
   canon ((i + 8) % 21) ((i + 10) % 21), canon ((i + 10) % 21) ((i + 3) % 21),
   canon ((i + 3) % 21) ((i + 18) % 21), canon ((i + 18) % 21) ((i + 13) % 21),
   canon ((i + 13) % 21) ((i + 17) % 21), canon ((i + 17) % 21) ((i + 20) % 21),
   canon ((i + 20) % 21) ((i + 1) % 21), canon ((i + 1) % 21) ((i + 2) % 21)}
def family : Finset Edge := (List.range 21).foldl (fun acc i => acc ∪ tree i) ∅
def k21Edges : Finset Edge := ((Finset.range 21).product (Finset.range 21)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k21Edges := by native_decide
end KotzigT10K21
