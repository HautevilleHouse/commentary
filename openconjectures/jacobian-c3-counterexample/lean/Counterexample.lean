/-! Kernel-checked finite replay of the reported collision.

The global Jacobian-determinant identity is checked by the SymPy checker;
this Lean file checks the exact rational evaluations and input
distinctness without axioms.
-/
def F (p : Rat × Rat × Rat) : Rat × Rat × Rat :=
  let x := p.1
  let y := p.2.1
  let z := p.2.2
  ((1 + x*y)^3*z + y^2*(1 + x*y)*(4 + 3*x*y),
   y + 3*x*(1 + x*y)^2*z + 3*x*y^2*(4 + 3*x*y),
   2*x - 3*x^2*y - x^3*z)

def p₁ : Rat × Rat × Rat := (0, 0, -1/4)
def p₂ : Rat × Rat × Rat := (1, -3/2, 13/2)
def p₃ : Rat × Rat × Rat := (-1, 3/2, 13/2)
def target : Rat × Rat × Rat := (-1/4, 0, 0)

theorem eval₁ : F p₁ = target := by native_decide
theorem eval₂ : F p₂ = target := by native_decide
theorem eval₃ : F p₃ = target := by native_decide
theorem inputs_distinct : p₁ ≠ p₂ ∧ p₁ ≠ p₃ ∧ p₂ ≠ p₃ := by native_decide

def det3 (a b c d e f g h i : Rat) : Rat :=
  a*(e*i - f*h) - b*(d*i - f*g) + c*(d*h - e*g)

def jacDetAt (p : Rat × Rat × Rat) : Rat :=
  let x := p.1; let y := p.2.1; let z := p.2.2
  det3
    (y*(3*x^2*y^2*z + 6*x*y^3 + 6*x*y*z + 7*y^2 + 3*z))
    (3*x^3*y^2*z + 12*x^2*y^3 + 6*x^2*y*z + 21*x*y^2 + 3*x*z + 8*y)
    ((x*y + 1)^3)
    (3*(3*x^2*y^2*z + 6*x*y^3 + 4*x*y*z + 4*y^2 + z))
    (6*x^3*y*z + 27*x^2*y^2 + 6*x^2*z + 24*x*y + 1)
    (3*x*(x*y + 1)^2)
    (-3*x^2*z - 6*x*y + 2) (-3*x^2) (-x^3)

theorem jacobian_at₁ : jacDetAt p₁ = -2 := by native_decide
theorem jacobian_at₂ : jacDetAt p₂ = -2 := by native_decide
theorem jacobian_at₃ : jacDetAt p₃ = -2 := by native_decide

def G (p : Rat × Rat × Rat) : Rat × Rat × Rat :=
  let q := F p
  (-q.1 / 2, q.2.1, q.2.2)

def scaledTarget : Rat × Rat × Rat := (1/8, 0, 0)

theorem scaled_eval₁ : G p₁ = scaledTarget := by native_decide
theorem scaled_eval₂ : G p₂ = scaledTarget := by native_decide
theorem scaled_eval₃ : G p₃ = scaledTarget := by native_decide
theorem scaled_noninjective : ∃ p q, p ≠ q ∧ G p = G q := by
  exact ⟨p₁, p₂, by native_decide, by native_decide⟩
