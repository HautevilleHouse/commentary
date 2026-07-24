# Kotzig T-Tree Cyclic Decomposition in K9

This bounded packet verifies the four-edge T-shaped tree with edges `(0,1), (0,2), (0,3), (3,4)`. The base embedding into `Z/9Z` is `{0:0, 1:1, 2:2, 3:3, 4:7}`. Its nine cyclic shifts partition all 36 edges of `K9`.

This is one finite Kotzig slice only. It does not settle Kotzig's general conjecture, which asks for every tree.

Replay:

```sh
python3 checkers/verify.py
ruby checkers/verify.rb
```

Source: `FormalConjectures/Paper/KotzigConjecture.lean`, commit `6f57f58effb32da91a5761c1a5491904a85921ab`, observed 2026-07-20. Wrapper digest: `ac94e5edde45dc3c9429a5fb7bee727a23251351898a5a12842a974f0d951612`.
