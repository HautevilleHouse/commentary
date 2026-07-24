from fractions import Fraction


def trim(poly):
    poly = poly[:]
    while poly and poly[-1] == 0:
        poly.pop()
    return poly or [Fraction(0)]


def degree(poly):
    poly = trim(poly)
    return -1 if poly == [0] else len(poly) - 1


def add(a, b):
    out = [Fraction(0)] * max(len(a), len(b))
    for i in range(len(out)):
        out[i] = (a[i] if i < len(a) else 0) + (b[i] if i < len(b) else 0)
    return trim(out)


def sub(a, b):
    out = [Fraction(0)] * max(len(a), len(b))
    for i in range(len(out)):
        out[i] = (a[i] if i < len(a) else 0) - (b[i] if i < len(b) else 0)
    return trim(out)


def mul(a, b):
    out = [Fraction(0)] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i + j] += x * y
    return trim(out)


def deriv(poly):
    return trim([Fraction(i) * poly[i] for i in range(1, len(poly))])


def divmod_poly(a, b):
    a = trim(a)
    b = trim(b)
    if b == [0]:
        raise ZeroDivisionError
    q = [Fraction(0)] * max(1, degree(a) - degree(b) + 1)
    r = a[:]
    db = degree(b)
    lb = b[-1]
    while degree(r) >= db and r != [0]:
        k = degree(r) - db
        c = r[-1] / lb
        q[k] = c
        r = sub(r, [Fraction(0)] * k + [c * coeff for coeff in b])
    return trim(q), trim(r)


def gcd_poly(a, b):
    a = trim(a)
    b = trim(b)
    while b != [0]:
        _, r = divmod_poly(a, b)
        a, b = b, r
    if a == [0]:
        return [Fraction(0)]
    lead = a[-1]
    return trim([x / lead for x in a])


def sturm_sequence(poly):
    seq = [trim(poly), trim(deriv(poly))]
    while seq[-1] != [0]:
        _, r = divmod_poly(seq[-2], seq[-1])
        seq.append(trim([-x for x in r]))
    return seq[:-1]


def eval_poly(poly, x):
    total = Fraction(0)
    power = Fraction(1)
    for coeff in poly:
        total += coeff * power
        power *= x
    return total


def sign_at_rational(poly, x):
    value = eval_poly(poly, x)
    return 0 if value == 0 else (1 if value > 0 else -1)


def sign_at_infinity(poly, positive):
    poly = trim(poly)
    if poly == [0]:
        return 0
    sign = 1 if poly[-1] > 0 else -1
    if not positive and degree(poly) % 2 == 1:
        sign = -sign
    return sign


def variations(signs):
    filtered = [s for s in signs if s != 0]
    return sum(1 for a, b in zip(filtered, filtered[1:]) if a != b)


def count_interval(seq, left, right):
    left_signs = (
        [sign_at_infinity(poly, positive=False) for poly in seq]
        if left == "-inf"
        else [sign_at_rational(poly, left) for poly in seq]
    )
    right_signs = (
        [sign_at_infinity(poly, positive=True) for poly in seq]
        if right == "inf"
        else [sign_at_rational(poly, right) for poly in seq]
    )
    return variations(left_signs) - variations(right_signs)


def poly_string(poly):
    poly = trim(poly)
    pieces = []
    for power in range(len(poly) - 1, -1, -1):
        coeff = poly[power]
        if coeff == 0:
            continue
        if coeff.denominator != 1:
            coeff_text = f"({coeff.numerator}/{coeff.denominator})"
        else:
            coeff_text = str(coeff.numerator)
        if power == 0:
            term = coeff_text
        elif power == 1:
            if coeff_text == "1":
                term = "x"
            elif coeff_text == "-1":
                term = "-x"
            else:
                term = f"{coeff_text}*x"
        else:
            if coeff_text == "1":
                term = f"x^{power}"
            elif coeff_text == "-1":
                term = f"-x^{power}"
            else:
                term = f"{coeff_text}*x^{power}"
        pieces.append(term)
    return " + ".join(pieces).replace("+ -", "- ")


def main():
    q = [
        Fraction(1),
        Fraction(10),
        Fraction(45),
        Fraction(150),
        Fraction(354),
        Fraction(492),
        Fraction(410),
        Fraction(210),
        Fraction(66),
        Fraction(12),
        Fraction(1),
    ]
    g = gcd_poly(q, deriv(q))
    seq = sturm_sequence(q)
    counts = (
        count_interval(seq, "-inf", Fraction(-2)),
        count_interval(seq, Fraction(-2), Fraction(-1, 2)),
        count_interval(seq, Fraction(-1, 2), Fraction(0)),
        count_interval(seq, "-inf", "inf"),
    )
    assert poly_string(g) == "1"
    assert counts == (0, 0, 2, 2)
    print(poly_string(q))
    print(f"gcd={poly_string(g)}")
    print(f"counts={counts[0]} {counts[1]} {counts[2]}")
    print(f"total_real={counts[3]}")


if __name__ == "__main__":
    main()
