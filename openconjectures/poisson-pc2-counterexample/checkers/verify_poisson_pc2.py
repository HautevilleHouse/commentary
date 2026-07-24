#!/usr/bin/env python3
"""Exact QQ replay for the displayed rank-2 Poisson endomorphism.

Checks the generator Poisson identities, R = x(2-3*x*q), det J = 1,
and the explicit three-point fiber. Emits JSON on stdout.
"""

from __future__ import annotations

import json
import sympy as sp

x, q, p, z = sp.symbols("x q p z")
vars4 = (x, q, p, z)

a = 1 - 3 * x * q
B = 3 * x**2 * p + 2 * a * z
beta = B - 9 * q**2
y = q - x * beta / 3
u = x * y

R = 2 * x - 3 * x**2 * y - x**3 * beta
S = y + 3 * x * (1 + x * y) ** 2 * beta + 3 * x * y**2 * (4 + 3 * x * y)
T = -sp.Rational(1, 2) * (
    (1 + x * y) ** 3 * beta + y**2 * (1 + x * y) * (4 + 3 * x * y)
)
D0 = sp.Rational(1, 2) * (1 + 3 * x * q) * p - 3 * q**2 * z
H = (
    y**4 / sp.Integer(20) * (18 * u**2 + 78 * u + 125)
    + sp.Rational(3, 10) * beta * y**2 * (u**3 + 5 * u**2 + 10 * u - 5)
    - beta**2 / sp.Integer(6) * (9 * u + 2)
    - x**2 * beta**3 / sp.Integer(6)
)
D = D0 + H
outputs = (R, T, D, S)


def poisson(f: sp.Expr, g: sp.Expr) -> sp.Expr:
    return (
        sp.diff(f, p) * sp.diff(g, x)
        - sp.diff(f, x) * sp.diff(g, p)
        + sp.diff(f, z) * sp.diff(g, q)
        - sp.diff(f, q) * sp.diff(g, z)
    )


def as_poly(expr: sp.Expr) -> sp.Poly:
    return sp.Poly(sp.expand(expr), *vars4, domain=sp.QQ)


def assert_zero(expr: sp.Expr, label: str) -> None:
    poly = as_poly(expr)
    if not poly.is_zero:
        raise AssertionError(f"FAILED {label}: {poly.as_expr()}")


assert_zero(R - x * (2 - 3 * x * q), "R = x(2-3xq)")

bracket_checks = {
    "{D,R}=1": poisson(D, R) - 1,
    "{S,T}=1": poisson(S, T) - 1,
    "{R,S}=0": poisson(R, S),
    "{R,T}=0": poisson(R, T),
    "{D,S}=0": poisson(D, S),
    "{D,T}=0": poisson(D, T),
}
for label, expr in bracket_checks.items():
    assert_zero(expr, label)

J4 = sp.Matrix([[sp.diff(f, v) for v in vars4] for f in outputs])
det4 = J4.det(method="domain-ge")
assert_zero(det4 - 1, "det J(R,T,D,S)=1")

points = (
    (sp.Rational(0), sp.Rational(0), sp.Rational(1, 24), sp.Rational(-1, 8)),
    (sp.Rational(1), sp.Rational(2, 3), sp.Rational(247, 96), sp.Rational(-89, 64)),
    (
        sp.Rational(-1),
        sp.Rational(-2, 3),
        sp.Rational(247, 96),
        sp.Rational(-89, 64),
    ),
)
target = (sp.Rational(0), sp.Rational(1, 8), sp.Rational(0), sp.Rational(0))
images = []
for i, point in enumerate(points, start=1):
    image = tuple(sp.cancel(f.subs(dict(zip(vars4, point)))) for f in outputs)
    if image != target:
        raise AssertionError(f"FAILED collision point {i}: {image}")
    images.append([str(v) for v in image])

size_data = {}
for name, expr in (
    ("beta", beta),
    ("y", y),
    ("R", R),
    ("S", S),
    ("T", T),
    ("H", H),
    ("D", D),
):
    poly = as_poly(expr)
    size_data[name] = {
        "term_count": len(poly.terms()),
        "total_degree": int(poly.total_degree()),
    }

out = {
    "packet": "poisson-pc2-counterexample",
    "sympy_version": sp.__version__,
    "generator_order": ["x", "q", "p", "z"],
    "output_order": ["R", "T", "D", "S"],
    "R_equals_x_times_2_minus_3xq": True,
    "poisson_brackets": {
        "{D,R}": "1",
        "{S,T}": "1",
        "{R,S}": "0",
        "{R,T}": "0",
        "{D,S}": "0",
        "{D,T}": "0",
    },
    "jacobian_determinant": "1",
    "collision_inputs": [[str(v) for v in pt] for pt in points],
    "collision_images": images,
    "collision_target": [str(v) for v in target],
    "all_distinct_inputs": len(set(points)) == 3,
    "size_table": size_data,
    "endpoint_check": True,
}
print(json.dumps(out, sort_keys=True, indent=2))
