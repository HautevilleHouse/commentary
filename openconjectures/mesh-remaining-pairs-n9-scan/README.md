# Remaining mesh-pattern pairs: finite `n≤9` scan

The source paper identifies three unresolved equidistribution pairs in
Classes 54, 69, and 71. This packet directly evaluates the source mesh-pattern
occurrence definition for each pair on every permutation in `S_n` for
`1 ≤ n ≤ 9`; a separate C++ enumerator extends the same comparison to
all `10!` permutations at `n=10`.
The same C++ evaluator also checks all `11!` permutations at
`n=11`.

Both implementations find identical occurrence-count histograms
for every pair at every tested size. This is finite evidence only: it proves
none of the three infinite equidistribution conjectures and found no
counterexample.

```sh
python3 checkers/scan.py
ruby checkers/scan.rb
clang++ -std=c++17 -O3 -Wall -Wextra -pedantic checkers/scan_n10.cpp -o /tmp/mesh_pairs_n10
/tmp/mesh_pairs_n10
clang++ -std=c++17 -O3 -march=native checkers/scan_n11.cpp -o /tmp/mesh_pairs_n11
/tmp/mesh_pairs_n11
```
