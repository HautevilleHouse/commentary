/-! Finite prefix lemmas; core Lean only (`omega`). -/

namespace AlmostGolombPrefix

/-- Membership in a closed interval shifts one place to the right.  This is
the indexing step used when the extra initial `2` shifts every later run. -/
theorem shift_closed_run
    {lo hi n : Nat} (hlo : lo ≤ n) (hhi : n ≤ hi) :
    lo + 1 ≤ n + 1 ∧ n + 1 ≤ hi + 1 := by
  omega

/-- If two sequences are constant with the same value on run intervals that
differ by one position, their values agree under the index shift. -/
theorem shifted_run_value
    (golomb almost : Nat → Nat) {lo hi n value : Nat}
    (hn : lo ≤ n ∧ n ≤ hi)
    (hgolomb : ∀ k, lo ≤ k → k ≤ hi → golomb k = value)
    (halmost : ∀ k, lo + 1 ≤ k → k ≤ hi + 1 → almost k = value) :
    almost (n + 1) = golomb n := by
  have shifted := shift_closed_run hn.1 hn.2
  rw [halmost (n + 1) shifted.1 shifted.2, hgolomb n hn.1 hn.2]

end AlmostGolombPrefix
