# Strong Sensitivity conjecture, finite `n=4` replay

Exhaustive enumeration of all `2^(2^4)=65,536` Boolean functions verifies
`blockSensitivity(f) <= sensitivity(f)^2` for the source definitions. The
distribution is `(0,0):2, (1,1):8, (2,2):668, (2,3):24, (3,3):28,328,
(4,4):36,506`; both maxima are 4.

This is only the finite `n=4` slice and does not settle the general conjecture.

```sh
python3 checkers/verify_python.py
node checkers/verify_node.js
```
