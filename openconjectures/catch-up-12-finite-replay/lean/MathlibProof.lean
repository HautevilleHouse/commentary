namespace CatchUp12Mathlib

inductive Outcome where | win | draw | loss
deriving DecidableEq

def flip : Outcome → Outcome
  | .win => .loss | .draw => .draw | .loss => .win
def rank : Outcome → Nat
  | .loss => 0 | .draw => 1 | .win => 2
def best (a b : Outcome) : Outcome := if rank a ≥ rank b then a else b
def terminal (me opp : Nat) : Outcome :=
  if me > opp then .win else if opp > me then .loss else .draw

def valueFuel : Nat → Nat → Nat → Nat → Bool → Outcome
  | 0, _, _, _, _ => .draw
  | fuel + 1, remaining, me, opp, first =>
      if remaining = 0 then terminal me opp
      else if me + (if remaining &&& 1 ≠ 0 then 1 else 0) +
          (if remaining &&& 2 ≠ 0 then 2 else 0) < opp then .loss
      else
        let one := if remaining &&& 1 = 0 then .loss else
          let me₂ := me + 1
          if first || me₂ ≥ opp then
            flip (valueFuel fuel (remaining - 1) opp me₂ false)
          else valueFuel fuel (remaining - 1) me₂ opp false
        let two := if remaining &&& 2 = 0 then .loss else
          let me₂ := me + 2
          if first || me₂ ≥ opp then
            flip (valueFuel fuel (remaining - 2) opp me₂ false)
          else valueFuel fuel (remaining - 2) me₂ opp false
        best one two

theorem initial_position_is_win :
    valueFuel 3 3 0 0 true = .win := by decide

theorem after_first_player_takes_two :
    valueFuel 2 1 0 2 false = .loss := by decide

end CatchUp12Mathlib
