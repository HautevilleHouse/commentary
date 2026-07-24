# Erdős 624: finite `H(3)` replay

For the exact Formal Conjectures definition of `H(n)`, this packet exhausts
all `3^8 = 6561` functions from the eight subsets of `X={0,1,2}` to `X`.
No function succeeds at thresholds `m=0` or `m=1`; 720 succeed at `m=2`.
The source-exact finite value is therefore `H(3)=2`.

Python and Ruby exhaustive checkers agree. This says nothing about
`H(4)`, `H(5)`, or the asymptotic conjecture.

```sh
python3 checkers/verify_python.py
ruby checkers/verify_ruby.rb
```

Source: [Formal Conjectures Erdős 624](https://github.com/google-deepmind/formal-conjectures/blob/c252a41054125b5fd9c8356e2137cd9b55337657/FormalConjectures/ErdosProblems/624.lean)
