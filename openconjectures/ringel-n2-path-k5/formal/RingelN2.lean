import Std

namespace RingelN2PathK5

abbrev Edge := Nat × Nat
abbrev Path := List Edge

def allEdges : List Edge :=
  [(0,1),(0,2),(0,3),(0,4),(1,2),(1,3),(1,4),(2,3),(2,4),(3,4)]

def copies : List Path :=
  [[(0,2),(1,2)], [(1,3),(2,3)], [(2,4),(3,4)],
   [(0,3),(0,4)], [(1,4),(0,1)]]

def usedEdges : List Edge := copies.flatten

def validPath (p : Path) : Bool :=
  p.length = 2 && p[0]?.isSome && p[1]?.isSome &&
    p[0]?.getD (0,0) != p[1]?.getD (0,0)

theorem all_edges_nodup : allEdges.Nodup := by decide
theorem used_edges_nodup : usedEdges.Nodup := by decide
theorem every_copy_valid : ∀ p ∈ copies, validPath p = true := by decide
theorem edge_partition :
    allEdges.all (fun e => e ∈ usedEdges) = true ∧
    usedEdges.all (fun e => e ∈ allEdges) = true := by decide

end RingelN2PathK5
