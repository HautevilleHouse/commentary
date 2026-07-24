# Erdős 647: three finite counterexamples

The pinned Formal Conjectures statement asks whether, for a given `n`, every
`m < n` satisfies `m + tau(m) <= n+2`, where `tau` counts positive divisors.
The following finite instances fail:

| n | witness m | tau(m) | m+tau(m) | bound n+2 |
|---|---:|---:|---:|---:|
| 25 | 24 | 8 | 32 | 27 |
| 26 | 24 | 8 | 32 | 28 |
| 30 | 28 | 6 | 34 | 32 |

Python and Ruby checkers enumerate every `m` in each finite
range and verify the divisor sets and violations. These counterexamples do
not settle the source's existential or asymptotic statements.

## Replay

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

Source: [Formal Conjectures Erdős 647](https://github.com/google-deepmind/formal-conjectures/blob/c252a41054125b5fd9c8356e2137cd9b55337657/FormalConjectures/ErdosProblems/647.lean)
