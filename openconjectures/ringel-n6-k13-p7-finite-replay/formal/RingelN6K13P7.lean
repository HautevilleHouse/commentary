import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range
namespace RingelN6K13P7
abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)
def path (i : Nat) : Finset Edge :=
  {canon (i % 13) ((i + 1) % 13), canon ((i + 1) % 13) ((i + 3) % 13),
   canon ((i + 3) % 13) ((i + 6) % 13), canon ((i + 6) % 13) ((i + 10) % 13),
   canon ((i + 10) % 13) ((i + 2) % 13), canon ((i + 2) % 13) ((i + 8) % 13)}
def family : Finset Edge := (List.range 13).foldl (fun acc i => acc ∪ path i) ∅
def k13Edges : Finset Edge := ((Finset.range 13).product (Finset.range 13)).filter (fun e => e.1 < e.2)
theorem cyclic_path_partition : family = k13Edges := by native_decide
end RingelN6K13P7
