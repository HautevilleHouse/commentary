namespace KotzigT6CyclicK13Mathlib

/-! Mathlib-backed companion for the published commentary packet `kotzig-t6-cyclic-k13`.

This Lake package pins Mathlib (v4.28.0 / `8f9d9cff…`) so the packet is
self-contained and rebuildable. The certificate/Python replay remains authoritative
for the mathematical claim; this file is the Mathlib shelf form.
-/

theorem mathlib_shelf_marker : True := by
  trivial

theorem packet_slug_length : (20 : Nat) = 20 := by
  decide

theorem packet_fin_inhabited : Nonempty (Fin 20) :=
  ⟨0⟩

end KotzigT6CyclicK13Mathlib
