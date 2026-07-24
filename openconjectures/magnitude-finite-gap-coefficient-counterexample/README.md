# Magnitude Finite-Gap Coefficient Counterexample

Source: arXiv:2603.04271v1, `Continuity of Magnitude at Skew Finite Subsets of ell_1^N`

Source object: OpenConjecture 756, determinant leading-coefficient claim for cubical-thickening zero-skeleton similarity matrices.

## Result

The Lean packet checks an ordered one-dimensional finite-gap counterfamily.

For every positive adjacent-gap family `gaps : Fin m -> R` with `0 < m`, the normalized determinant has limit:

```text
4^(m+1) * product_i (1 - exp(-2 * gaps_i))
```

The paper-level coefficient predicted by the encoded `N = 1` specialization is:

```text
4^(m+1)
```

Since each positive middle-gap attenuation factor is strictly below `1`, the normalized determinant does not tend to the predicted coefficient. This gives a checked `N = 1` finite-gap counterfamily to the universal coefficient statement.

## Lean Anchors

- `finiteGapSmallRadius_eventually_of_skew`
- `finiteGapDeterminantProductLaw_of_skew`
- `finiteGapZeroSkeletonDet_normalized_tendsto_actualCoefficient_of_skew`
- `finiteGapMiddleAttenuationProduct_lt_one_of_skew_nonempty`
- `finiteGapZeroSkeletonDet_normalized_not_tendsto_source_coefficient_of_skew_nonempty`

## Replay

Run from this directory:

```bash
cd lean
lake build MagnitudeGeneralizationBoundary
```

The public packet contains a minimal Lake target for the two Lean files. The included Lake manifest pins the dependency graph used for the public replay.

## Artifacts

- [Lean package](lean/)
- [Lake manifest](lean/lake-manifest.json)
- [Source identity](data/source_identity.json)
- [Build receipt](data/build_receipt.json)
- [Public packet build log](data/public_packet_build_20260708.log)

## Boundary

Closed: the ordered finite-gap `ell_1^1` counterfamily currently encoded in Lean.

Carried: arbitrary higher-dimensional `ell_1^N` replacement or classification theorems remain separate work. The public claim here is coefficient refutation by a checked one-dimensional finite-gap family.
