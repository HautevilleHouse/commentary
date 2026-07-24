# Pinned Lake companion replay

This wrapper rechecks the Hoffman–Singleton spectral bridge and the numerical
refutation of Graffiti 284 under the packet's Lake package. The certificate is
stdlib-only so it stays self-contained and rebuildable without a Mathlib fetch. Run
from `lean/` with:

```bash
lake env lean ../formal/mathlib/Graffiti284HoffmanSingletonCounterexampleMathlib.lean
```
