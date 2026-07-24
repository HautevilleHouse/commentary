import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace KotzigT12K25
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def tree (i : Nat) : Finset Edge :=
  {canon (i % 25) ((i + 11) % 25), canon ((i + 11) % 25) ((i + 13) % 25),
   canon ((i + 13) % 25) ((i + 1) % 25), canon ((i + 1) % 25) ((i + 24) % 25),
   canon ((i + 24) % 25) ((i + 2) % 25), canon ((i + 2) % 25) ((i + 23) % 25),
   canon ((i + 23) % 25) ((i + 3) % 25), canon ((i + 3) % 25) ((i + 22) % 25),
   canon ((i + 22) % 25) ((i + 4) % 25), canon ((i + 4) % 25) ((i + 21) % 25),
   canon ((i + 21) % 25) ((i + 5) % 25), canon ((i + 5) % 25) ((i + 20) % 25)}
def family : Finset Edge := (List.range 25).foldl (fun acc i => acc ∪ tree i) ∅
def k25Edges : Finset Edge := ((Finset.range 25).product (Finset.range 25)).filter (fun e => e.1 < e.2)
theorem cyclic_tree_partition : family = k25Edges := by native_decide
end KotzigT12K25
