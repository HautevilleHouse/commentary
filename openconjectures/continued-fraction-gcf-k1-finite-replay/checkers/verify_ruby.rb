require "rational"

n = 5000
partial = Rational(0, 1)
(1..n).each { |i| partial += Rational(1, i**3) }
zeta_lo = partial + Rational(1, 2 * (n + 1)**2)
zeta_hi = zeta_lo + Rational(1, (n + 1)**3)
g2_lo = (zeta_lo - Rational(251, 216)) / 2
g2_hi = (zeta_hi - Rational(251, 216)) / 2
checks = [
  g2_lo > Rational(1, 64),
  g2_hi < Rational(1, 49),
  g2_lo > Rational(14, 99)**2,
  g2_hi < Rational(15, 106)**2
]
raise "failed" unless checks.all?
puts "N=3 a1=7 a2=14; rigorous rational interval checks=4/4"
