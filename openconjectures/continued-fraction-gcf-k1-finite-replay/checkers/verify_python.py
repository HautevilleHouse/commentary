from fractions import Fraction

N = 5000
partial = sum((Fraction(1, n**3) for n in range(1, N + 1)), Fraction())
zeta_lo = partial + Fraction(1, 2 * (N + 1) ** 2)
zeta_hi = zeta_lo + Fraction(1, (N + 1) ** 3)
g2_lo = (zeta_lo - Fraction(251, 216)) / 2
g2_hi = (zeta_hi - Fraction(251, 216)) / 2
checks = [
    g2_lo > Fraction(1, 64),   # g > 1/8, so a1 = 7
    g2_hi < Fraction(1, 49),   # g < 1/7
    g2_lo > Fraction(14, 99) ** 2,  # r > 1/15, so a2 <= 14
    g2_hi < Fraction(15, 106) ** 2, # r < 1/14, so a2 >= 14
]
assert all(checks)
print("N=3 a1=7 a2=14; rigorous rational interval checks=4/4")
