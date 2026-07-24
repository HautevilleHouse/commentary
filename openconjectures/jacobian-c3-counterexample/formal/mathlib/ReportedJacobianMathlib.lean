import Mathlib.Tactic.Ring

namespace ReportedJacobianMathlib
def j11 (x y z : ℚ) := y*(3*x^2*y^2*z + 6*x*y^3 + 6*x*y*z + 7*y^2 + 3*z)
def j12 (x y z : ℚ) := 3*x^3*y^2*z + 12*x^2*y^3 + 6*x^2*y*z + 21*x*y^2 + 3*x*z + 8*y
def j13 (x y z : ℚ) := (x*y + 1)^3
def j21 (x y z : ℚ) := 3*(3*x^2*y^2*z + 6*x*y^3 + 4*x*y*z + 4*y^2 + z)
def j22 (x y z : ℚ) := 6*x^3*y*z + 27*x^2*y^2 + 6*x^2*z + 24*x*y + 1
def j23 (x y z : ℚ) := 3*x*(x*y + 1)^2
def j31 (x y z : ℚ) := -3*x^2*z - 6*x*y + 2
def j32 (x y z : ℚ) := -3*x^2
def j33 (x y z : ℚ) := -x^3
def det3 (a b c d e f g h i : ℚ) := a*(e*i-f*h)-b*(d*i-f*g)+c*(d*h-e*g)
def jacDet (x y z : ℚ) := det3 (j11 x y z) (j12 x y z) (j13 x y z) (j21 x y z) (j22 x y z) (j23 x y z) (j31 x y z) (j32 x y z) (j33 x y z)
theorem jacDet_identity (x y z : ℚ) : jacDet x y z = -2 := by
  dsimp [jacDet, det3, j11, j12, j13, j21, j22, j23, j31, j32, j33]
  ring
end ReportedJacobianMathlib
