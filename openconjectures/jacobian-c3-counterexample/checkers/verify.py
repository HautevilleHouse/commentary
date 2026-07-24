#!/usr/bin/env python3
import json
import sympy as sp

x, y, z = sp.symbols("x y z")
F = [
    (1 + x*y)**3*z + y**2*(1 + x*y)*(4 + 3*x*y),
    y + 3*x*(1 + x*y)**2*z + 3*x*y**2*(4 + 3*x*y),
    2*x - 3*x**2*y - x**3*z,
]
vars_ = (x, y, z)
points = [
    (0, 0, sp.Rational(-1, 4)),
    (1, sp.Rational(-3, 2), sp.Rational(13, 2)),
    (-1, sp.Rational(3, 2), sp.Rational(13, 2)),
]
images = [tuple(sp.factor(f.subs(dict(zip(vars_, p)))) for f in F) for p in points]
out = {
    "determinant": str(sp.factor(sp.Matrix(F).jacobian(vars_).det())),
    "inputs": [[str(v) for v in p] for p in points],
    "images": [[str(v) for v in q] for q in images],
    "target": ["-1/4", "0", "0"],
    "all_distinct_inputs": len(set(points)) == 3,
}
assert out["determinant"] == "-2"
assert out["all_distinct_inputs"]
assert all(q == (sp.Rational(-1, 4), 0, 0) for q in images)
print(json.dumps(out, sort_keys=True))
