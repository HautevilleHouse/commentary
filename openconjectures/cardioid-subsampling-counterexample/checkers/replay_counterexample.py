#!/usr/bin/env python3
"""Replay the OpenConjecture 4648 cardioid closure counterexample."""

from __future__ import annotations

import cmath
import hashlib
import json
import math
import platform
from fractions import Fraction
from pathlib import Path


PROJECT = Path(__file__).resolve().parents[1]
OUTPUT_PATH = PROJECT / "data" / "counterexample_check_20260717.json"
QUADRATURE_POINTS = 1 << 16
MAX_MODE = 8
TOLERANCE = 2.0e-10
PARAMETERS = (Fraction(1, 10), Fraction(1, 4), Fraction(1, 2))


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def cardioid_density(theta: float, rho: float) -> float:
    return (1.0 + 2.0 * rho * math.cos(theta)) / (2.0 * math.pi)


def midpoint_moments(rho: float) -> tuple[float, dict[int, complex], dict[int, complex]]:
    step = 2.0 * math.pi / QUADRATURE_POINTS
    normalization = 0.0
    central = {mode: 0.0j for mode in range(1, MAX_MODE + 1)}
    half = {mode: 0.0j for mode in range(1, MAX_MODE + 1)}
    for index in range(QUADRATURE_POINTS):
        theta = -math.pi + (index + 0.5) * step
        weight = cardioid_density(theta, rho) * step
        normalization += weight
        for mode in range(1, MAX_MODE + 1):
            central[mode] += weight * cmath.exp(1j * mode * theta)
            half[mode] += weight * cmath.exp(0.5j * mode * theta)
    return normalization, central, half


def expected_central_mode(rho: float, mode: int) -> float:
    return rho if mode == 1 else 0.0


def case_payload(parameter: Fraction) -> dict:
    rho = float(parameter)
    h_one = 2.0 * (2.0 * rho + 3.0) / (3.0 * math.pi)
    rho_hat = rho * h_one * h_one
    normalization, central, half = midpoint_moments(rho)
    output = {
        mode: central[mode] * half[mode] * half[mode]
        for mode in range(1, MAX_MODE + 1)
    }
    central_errors = {
        str(mode): abs(central[mode] - expected_central_mode(rho, mode))
        for mode in range(1, MAX_MODE + 1)
    }
    higher_output_magnitude = max(abs(output[mode]) for mode in range(2, MAX_MODE + 1))
    minimum_density = (1.0 - 2.0 * rho) / (2.0 * math.pi)
    checks = {
        "density_is_nonnegative": minimum_density >= 0.0,
        "density_normalizes_by_quadrature": abs(normalization - 1.0) < TOLERANCE,
        "central_fourier_modes_match_cardioid": max(central_errors.values()) < TOLERANCE,
        "half_angle_moment_matches_formula": abs(half[1] - h_one) < TOLERANCE,
        "output_first_mode_matches_parameter_map": abs(output[1] - rho_hat) < TOLERANCE,
        "output_higher_modes_vanish": higher_output_magnitude < TOLERANCE,
        "output_parameter_is_nonuniform": rho_hat > 0.0,
        "output_parameter_is_valid": rho_hat <= 0.5,
        "output_parameter_contracts": rho_hat < rho,
    }
    return {
        "rho": {"fraction": f"{parameter.numerator}/{parameter.denominator}", "decimal": rho},
        "minimum_density": minimum_density,
        "quadrature_normalization": normalization,
        "h_one": h_one,
        "rho_hat": rho_hat,
        "central_mode_errors": central_errors,
        "output_first_mode": {
            "real": output[1].real,
            "imaginary": output[1].imag,
        },
        "maximum_higher_output_mode_magnitude": higher_output_magnitude,
        "checks": checks,
    }


def build_payload() -> dict:
    cases = [case_payload(parameter) for parameter in PARAMETERS]
    checks = {
        "all_case_checks_pass": all(
            all(case["checks"].values()) for case in cases
        ),
        "largest_half_angle_moment_is_below_one": 8.0 / (3.0 * math.pi) < 1.0,
        "endpoint_parameter_formula_matches": abs(
            cases[-1]["rho_hat"] - 32.0 / (9.0 * math.pi * math.pi)
        ) < TOLERANCE,
    }
    payload = {
        "source": {
            "openconjecture_id": 4648,
            "arxiv_id": "2607.03186v1",
            "source_file": "main.tex",
            "theorem_lines": "125-134",
            "derivation_lines": "165-195",
            "conjecture_lines": "613-619",
            "source_theorem_sha256": "13f1a2243fcd15566e0dce1d489d161d21662350ea977a5e2201c6d3b5655bc5",
            "source_conjecture_1_sha256": "52d62228253c2a0721b6eac8374976fd12ccd5139845a328e958a09220759fae",
            "source_conjecture_2_sha256": "9d96216204ea4cafd664615edd1e34c00ff979e14a91b08d96aab7d5e3ebfc04",
        },
        "family": {
            "name": "centered cardioid",
            "density": "f_rho(theta)=(1+2*rho*cos(theta))/(2*pi)",
            "parameter_domain": "0<rho<=1/2",
            "central_fourier_coefficients": "phi_0=1, phi_1=phi_-1=rho, phi_m=0 for |m|>=2",
        },
        "transform": {
            "sampling_rate": 2,
            "step_lengths": "fixed equal positive",
            "output_fourier_coefficient": "phi_m*h_m^2",
            "h_one": "2*(2*rho+3)/(3*pi)",
            "rho_hat": "4*rho*(2*rho+3)^2/(9*pi^2)",
        },
        "quadrature": {
            "method": "periodic midpoint rule",
            "points": QUADRATURE_POINTS,
            "maximum_mode": MAX_MODE,
            "tolerance": TOLERANCE,
        },
        "cases": cases,
        "checks": checks,
        "environment": {
            "python": platform.python_version(),
            "script_sha256": sha256_bytes(Path(__file__).read_bytes()),
        },
    }
    payload["payload_sha256_without_self"] = sha256_bytes(
        json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
    )
    return payload


def main() -> None:
    payload = build_payload()
    if not all(payload["checks"].values()):
        raise SystemExit("one or more top-level counterexample checks failed")
    if not all(all(case["checks"].values()) for case in payload["cases"]):
        raise SystemExit("one or more parameter checks failed")
    OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_PATH.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"wrote {OUTPUT_PATH.relative_to(PROJECT)}")


if __name__ == "__main__":
    main()
