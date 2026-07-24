def rat(n, d = 1)
  Rational(n, d)
end

def trim(poly)
  poly = poly.dup
  poly.pop while poly.length > 1 && poly[-1] == 0
  poly
end

def degree(poly)
  p = trim(poly)
  p == [0] ? -1 : p.length - 1
end

def add(a, b)
  out = Array.new([a.length, b.length].max, rat(0))
  out.each_index do |i|
    out[i] = (i < a.length ? a[i] : 0) + (i < b.length ? b[i] : 0)
  end
  trim(out)
end

def sub(a, b)
  out = Array.new([a.length, b.length].max, rat(0))
  out.each_index do |i|
    out[i] = (i < a.length ? a[i] : 0) - (i < b.length ? b[i] : 0)
  end
  trim(out)
end

def mul(a, b)
  out = Array.new(a.length + b.length - 1, rat(0))
  a.each_index do |i|
    b.each_index do |j|
      out[i + j] += a[i] * b[j]
    end
  end
  trim(out)
end

def deriv(poly)
  trim((1...poly.length).map { |i| rat(i) * poly[i] })
end

def divmod_poly(a, b)
  a = trim(a)
  b = trim(b)
  raise ZeroDivisionError if b == [0]
  q = Array.new([1, degree(a) - degree(b) + 1].max, rat(0))
  r = a.dup
  db = degree(b)
  lb = b[-1]
  while degree(r) >= db && r != [0]
    k = degree(r) - db
    c = r[-1] / lb
    q[k] = c
    r = sub(r, Array.new(k, rat(0)) + b.map { |coeff| c * coeff })
  end
  [trim(q), trim(r)]
end

def gcd_poly(a, b)
  a = trim(a)
  b = trim(b)
  while b != [0]
    _, r = divmod_poly(a, b)
    a = b
    b = r
  end
  return [0] if a == [0]
  lead = a[-1]
  trim(a.map { |x| x / lead })
end

def sturm_sequence(poly)
  seq = [trim(poly), trim(deriv(poly))]
  while seq[-1] != [0]
    _, r = divmod_poly(seq[-2], seq[-1])
    seq << trim(r.map { |x| -x })
  end
  seq[0...-1]
end

def eval_poly(poly, x)
  total = rat(0)
  power = rat(1)
  poly.each do |coeff|
    total += coeff * power
    power *= x
  end
  total
end

def sign_at_rational(poly, x)
  value = eval_poly(poly, x)
  return 0 if value == 0
  value > 0 ? 1 : -1
end

def sign_at_infinity(poly, positive)
  poly = trim(poly)
  return 0 if poly == [0]
  sign = poly[-1] > 0 ? 1 : -1
  sign = -sign if !positive && degree(poly).odd?
  sign
end

def variations(signs)
  filtered = signs.reject(&:zero?)
  filtered.each_cons(2).count { |a, b| a != b }
end

def count_interval(seq, left, right)
  left_signs =
    if left == :neg_inf
      seq.map { |poly| sign_at_infinity(poly, false) }
    else
      seq.map { |poly| sign_at_rational(poly, left) }
    end
  right_signs =
    if right == :pos_inf
      seq.map { |poly| sign_at_infinity(poly, true) }
    else
      seq.map { |poly| sign_at_rational(poly, right) }
    end
  variations(left_signs) - variations(right_signs)
end

def poly_string(poly)
  poly = trim(poly)
  pieces = []
  (poly.length - 1).downto(0) do |power|
    coeff = poly[power]
    next if coeff == 0
    coeff_text =
      if coeff.denominator != 1
        "(#{coeff.numerator}/#{coeff.denominator})"
      else
        coeff.numerator.to_s
      end
    term =
      if power == 0
        coeff_text
      elsif power == 1
        coeff_text == "1" ? "x" : (coeff_text == "-1" ? "-x" : "#{coeff_text}*x")
      else
        coeff_text == "1" ? "x^#{power}" : (coeff_text == "-1" ? "-x^#{power}" : "#{coeff_text}*x^#{power}")
      end
    pieces << term
  end
  pieces.join(" + ").gsub("+ -", "- ")
end

q = [1, 10, 45, 150, 354, 492, 410, 210, 66, 12, 1].map { |n| rat(n) }
g = gcd_poly(q, deriv(q))
seq = sturm_sequence(q)
counts = [
  count_interval(seq, :neg_inf, rat(-2)),
  count_interval(seq, rat(-2), rat(-1, 2)),
  count_interval(seq, rat(-1, 2), rat(0)),
  count_interval(seq, :neg_inf, :pos_inf)
]

raise unless poly_string(g) == "1"
raise unless counts == [0, 0, 2, 2]

puts poly_string(q)
puts "gcd=#{poly_string(g)}"
puts "counts=#{counts[0]} #{counts[1]} #{counts[2]}"
puts "total_real=#{counts[3]}"
