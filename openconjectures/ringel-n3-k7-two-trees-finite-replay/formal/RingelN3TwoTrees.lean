import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Range

namespace RingelN3TwoTrees

abbrev Edge := Nat × Nat

def canon (a b : Nat) : Edge := if a < b then (a, b) else (b, a)

def pathTree (i : Nat) : Finset Edge :=
  {canon (i % 7) ((i + 1) % 7),
   canon ((i + 1) % 7) ((i + 3) % 7),
   canon ((i + 3) % 7) ((i + 6) % 7)}

def starTree (i : Nat) : Finset Edge :=
  {canon (i % 7) ((i + 1) % 7),
   canon (i % 7) ((i + 2) % 7),
   canon (i % 7) ((i + 3) % 7)}

def familyUnion (f : Nat → Finset Edge) : Finset Edge :=
  (List.range 7).foldl (fun acc i => acc ∪ f i) ∅

def k7Edges : Finset Edge :=
  {(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),
   (1,2),(1,3),(1,4),(1,5),(1,6),
   (2,3),(2,4),(2,5),(2,6),
   (3,4),(3,5),(3,6),
   (4,5),(4,6),(5,6)}

theorem path_partition : familyUnion pathTree = k7Edges := by
  native_decide

theorem star_partition : familyUnion starTree = k7Edges := by
  native_decide

theorem both_tree_partitions :
    familyUnion pathTree = k7Edges ∧ familyUnion starTree = k7Edges :=
  ⟨path_partition, star_partition⟩

end RingelN3TwoTrees
