import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range

namespace RingelN4K9Star

abbrev Edge := Nat × Nat
def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)

def star (i : Nat) : Finset Edge :=
  {canon (i % 9) ((i + 1) % 9), canon (i % 9) ((i + 2) % 9),
   canon (i % 9) ((i + 3) % 9), canon (i % 9) ((i + 4) % 9)}

def family : Finset Edge :=
  (List.range 9).foldl (fun acc i => acc ∪ star i) ∅

def k9Edges : Finset Edge :=
  {(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),
   (1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),
   (2,3),(2,4),(2,5),(2,6),(2,7),(2,8),
   (3,4),(3,5),(3,6),(3,7),(3,8),
   (4,5),(4,6),(4,7),(4,8),
   (5,6),(5,7),(5,8),(6,7),(6,8),(7,8)}

theorem cyclic_star_partition : family = k9Edges := by
  native_decide

end RingelN4K9Star
