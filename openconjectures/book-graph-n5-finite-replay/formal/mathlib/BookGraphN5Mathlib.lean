import Mathlib.Tactic.Ring

namespace BookGraphN5Mathlib

def Q (x : ℚ) : ℚ :=
  x^10 + 12*x^9 + 66*x^8 + 210*x^7 + 410*x^6 + 492*x^5 +
  354*x^4 + 150*x^3 + 45*x^2 + 10*x + 1

theorem expansion_identity (x : ℚ) :
    (2*x + 1) * (x * (x + 2))^5 + x^2 * ((x + 1)^2)^5 - 2*x^5 =
      x^2 * Q x := by
  dsimp [Q]
  ring

end BookGraphN5Mathlib
