# Cardioid Subsampling Counterexample

Source paper: Joseph D. Bailey and Jessica Claridge,
[Effect of sampling on the descriptive distributions of correlated random walks](https://arxiv.org/abs/2607.03186v1).

Source object: OpenConjecture `4648`, arXiv:`2607.03186v1`, Conjectures 1
and 2 in `main.tex`, lines `613-619`, read with Theorem 1 at lines `125-134`
and its turning-angle derivation at lines `165-195`.

## Source Claim

Conjecture 1 excludes every nonuniform circular family whose parameterized
form is preserved by sampling at rate `r=2`, regardless of the step-length
distribution. Conjecture 2 makes the analogous exclusion for integer
`r>=2`. The source states that Conjecture 1 should follow directly from its
fixed-positive-step Theorem 1.

## Counterexample

Consider the centered cardioid family

```text
f_rho(theta) = (1 + 2 rho cos(theta)) / (2 pi),
-pi < theta <= pi,  0 < rho <= 1/2.
```

These are smooth, symmetric, nonuniform circular densities. Apply the
fixed-step `r=2` transform in Theorem 1. If `T` has density `f_rho`, the two
scaled convolution factors in that theorem have the distribution of `T/2`.
After wrapping the resulting convolution to the circle, its integer Fourier
coefficient at mode `m` is

```text
phi_m h_m^2,
```

where

```text
phi_m = E[exp(i m T)],
h_m   = E[exp(i m T/2)].
```

For the centered cardioid density,

```text
phi_0 = 1,
phi_1 = phi_-1 = rho,
phi_m = 0 for |m| >= 2.
```

The only nonconstant output mode is therefore `m=1`. Symmetry makes its
half-angle moment real, and direct integration gives

```text
h_1 = integral cos(theta/2) f_rho(theta) dtheta
    = 2(2 rho + 3) / (3 pi).
```

Consequently the sampled circular density is exactly another centered
cardioid density,

```text
f_rho -> f_rho_hat,

rho_hat = rho h_1^2
        = 4 rho (2 rho + 3)^2 / (9 pi^2).
```

For `0<rho<=1/2`,

```text
0 < h_1 <= 8/(3 pi) < 1,
0 < rho_hat < rho <= 1/2.
```

Thus the output remains a valid, nonuniform member of the same circular
family. For example, `rho=1/2` maps to
`rho_hat=32/(9 pi^2)=0.3602530973949787...`.

## Replay

Run from the repository root:

```bash
python3 openconjectures/cardioid-subsampling-counterexample/checkers/replay_counterexample.py
```

The standard-library checker verifies density validity, the exact Fourier
formulas, the parameter map, and numerical quadrature for three nonuniform
parameters. It writes `data/counterexample_check_20260717.json`.

## Files

- `data/source_identity.json` records the public source identity and hashes.
- `checkers/replay_counterexample.py` verifies the Fourier calculation.
- `data/prior_public_resolution_search_20260717.json` records the bounded public-resolution search receipt.
  public search and its limitations.
- `data/replay_receipt.json` records replay hashes and the claim boundary.

## Claim Boundary

- The packet refutes the source's fixed-positive-step, `r=2` reading of
  Conjecture 1 by applying Theorem 1 exactly as printed.
- Under the analogous exclusion reading, the same `r=2` witness also refutes
  Conjecture 2, since that statement includes `r=2`.
- The packet establishes closure only for fixed equal positive step lengths
  and `r=2`. It makes no claim for variable step-length distributions or for
  `r>2`.
- If "regardless of step-length distribution" instead requires one family to
  remain closed simultaneously for every step-length distribution, that
  stronger uniform-in-distribution statement remains outside this packet.
