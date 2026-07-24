import Lake

open Lake DSL

package AlmostGolombPrefix where
  version := v!"0.1.0"
  keywords := #["math", "lean", "openconjecture", "sequences"]
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`relaxedAutoImplicit, false⟩,
    ⟨`weak.linter.mathlibStandardSet, true⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.28.0"

@[default_target]
lean_lib AlmostGolombPrefix
