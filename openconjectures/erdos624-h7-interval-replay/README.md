# Erdős 624: bounded interval for `H(7)`

This packet records the exact bounded result currently supported for the
seven-color slice: `3 <= H(7) <= 4`. The explicit 128-entry table covers all
99 target sets of sizes 4 through 7, proving `H(7) <= 4`. Any target of size
2 has only four subsets, proving `H(7) >= 3`. The unresolved `m=3` case is
not claimed settled.

## Replays

```sh
python3 checkers/verify_h7_m4.py
ruby checkers/verify_h7_m4.rb
```

Both implementations must print the interval and report all 99 targets
covered at `m=4`. The exact source statement, hashes, and remainder are in
`source/source_exact_statement.txt` and `result.json`.
