import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace RingelN5K11P6
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def path (i : Nat) : Finset Edge :=
  {canon (i % 11) ((i + 5) % 11), canon ((i + 5) % 11) ((i + 1) % 11),
   canon ((i + 1) % 11) ((i + 4) % 11), canon ((i + 4) % 11) ((i + 2) % 11),
   canon ((i + 2) % 11) ((i + 3) % 11)}
def family : Finset Edge := (List.range 11).foldl (fun acc i => acc ∪ path i) ∅
def k11Edges : Finset Edge := ((Finset.range 11).product (Finset.range 11)).filter (fun e => e.1 < e.2)
theorem cyclic_path_partition : family = k11Edges := by native_decide
end RingelN5K11P6
