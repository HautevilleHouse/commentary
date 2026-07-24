# Dice pqr Counterexample

Source: arXiv:2606.20311v1, `Dice Relabeling Using Square-Sided Dice`

Source object: Conjecture `con:pqr` in the pqr square-sided dice section.

## Counterexample Instance

```text
(a,b,c,d) = (1,1,1,1)
(p,q,r) = (3,5,11)
paired B exponents = (1,1,1,1)
```

The instance lies outside the table condition `max(p,q,r)=r, min(p,q,r)=2`
and inside the source-worded conjectured negative remainder.

The certificate checks:

```text
A_min_coefficient = 0
B_pair_min_coefficient = 0
A(1) = 225 = 3^2 * 5^2
B(1) = 121 = 11^2
A * B = (x + x^2 + ... + x^165)^2
```

## Replay

Run:

```bash
python3 openconjectures/dice-pqr-counterexample/checkers/replay_counterexample.py
```

The replay script uses exact integer polynomial arithmetic and compares its
coefficient hashes with the certificate JSON.

The checker uses Python's standard library only.

## Lean

Run:

```bash
cd openconjectures/dice-pqr-counterexample/lean
lake build DicePqrCounterexample
```

The Lean target checks the packet-scope certificate facts for the exact
counterexample instance, including the finite coefficient-list product against
the standard two-dice frequency polynomial. The source-formula reconstruction
and coefficient hash checks remain in the Python checker and certificate JSON.

## Classification Boundary

For a counterexample packet, the mathematician-facing closure object is one
exact source-worded counterexample with reproducible arithmetic. A complete
symbolic pqr classification or repaired source theorem is a separate closure
package.

The bounded case-classification table records the current finite search
context: `81` cases, `210` ordered prime triples through prime bound `17`, and
`20` source-conjecture counterexample instances within that bound.

## Artifacts

- [Source identity](data/source_identity.json)
- [Classification boundary receipt](data/classification_boundary_20260708.json)
- [Bounded case classification](data/dice_pqr_case_classification.csv)
- [Lean source](lean/DicePqrCounterexample.lean)
- [Lean Lake config](lean/lakefile.toml)
- [Lean Lake manifest](lean/lake-manifest.json)
- [Lean toolchain](lean/lean-toolchain)
- [Lean build receipt](data/lean_build_receipt.json)
- [Lean build log](data/lean_build_20260708.log)
- [Replay receipt](data/replay_receipt.json)
- [Replay output](data/replay_output_20260708.json)
- [Counterexample certificate](data/dice_pqr_counterexample_1111_p3_q5_r11.json)
- [Bounded counterexample instance index](data/dice_pqr_counterexample_instances.csv)
- [Replay script](checkers/replay_counterexample.py)
- [Dependency marker](checkers/requirements.txt)

## Boundary

The closed object here is the source-worded counterexample instance above.
Complete symbolic classification of all pqr cases and the repaired source
theorem are separate closure packages.
