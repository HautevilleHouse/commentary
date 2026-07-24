# CRIM Conway pair `[4,4]` finite replay

Under the pinned CRIM move definition, `[4,4]` reaches `[4]` and then `[]`.
The normal/misere mex values are respectively `(0,1)`, `(1,0)`, and `(0,1)`,
so the Conway pair of `[4,4]` is `(0,1)`.

This is a finite replay only, not a general CRIM classification.

```sh
python3 math_research/checkers/crim_cp01_44_checker.py
ruby math_research/checkers/crim_cp01_44_checker.rb
```
