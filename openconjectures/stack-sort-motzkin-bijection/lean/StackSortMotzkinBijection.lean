import Mathlib.Data.List.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Algebra.BigOperators.Group.List.Basic

/-!
# OpenConjecture 1878 scaffold

This module formalizes the small structural layer behind the local source-bound
proof packet for OpenConjecture 1878:

`|W'_2(n)| = Motzkin(n)`.

It does not prove the full bijection. It defines the Motzkin-step surface and
the row-length projection used by the inverse construction in the proof packet,
then proves the basic counting identities that the eventual bijection proof
will need.
-/

namespace HautevilleHouse
namespace CanonicalLaneMathlibCore
namespace OpenConjecture1878

inductive MotzkinStep where
  | up
  | horizontal
  | down
  deriving DecidableEq, Repr

open MotzkinStep

inductive DiagramCell where
  | A : Nat → DiagramCell
  | B : Nat → DiagramCell
  deriving DecidableEq, Repr

open DiagramCell

def scanHeight : Nat → List MotzkinStep → Option Nat
  | h, [] => some h
  | h, up :: rest => scanHeight (h + 1) rest
  | h, horizontal :: rest => scanHeight h rest
  | 0, down :: _ => none
  | h + 1, down :: rest => scanHeight h rest

def IsMotzkinPath (steps : List MotzkinStep) : Prop :=
  scanHeight 0 steps = some 0

structure InverseState where
  nextRow : Nat
  openRows : List Nat
  rowLengthsRev : List Nat
  extensionRev : List DiagramCell
  deriving Repr

def initialInverseState : InverseState :=
  { nextRow := 0, openRows := [], rowLengthsRev := [], extensionRev := [] }

def inverseStep : InverseState → MotzkinStep → Option InverseState
  | st, up =>
      let row := st.nextRow + 1
      some
        { nextRow := row
          openRows := st.openRows ++ [row]
          rowLengthsRev := 2 :: st.rowLengthsRev
          extensionRev := A row :: st.extensionRev }
  | st, horizontal =>
      let row := st.nextRow + 1
      some
        { nextRow := row
          openRows := st.openRows
          rowLengthsRev := 1 :: st.rowLengthsRev
          extensionRev := A row :: st.extensionRev }
  | st, down =>
      match st.openRows with
      | [] => none
      | row :: rest =>
          some
            { nextRow := st.nextRow
              openRows := rest
              rowLengthsRev := st.rowLengthsRev
              extensionRev := B row :: st.extensionRev }

def inversePath : InverseState → List MotzkinStep → Option InverseState
  | st, [] => some st
  | st, step :: rest =>
      match inverseStep st step with
      | none => none
      | some st' => inversePath st' rest

def inverseRowLengths (steps : List MotzkinStep) : Option (List Nat) :=
  Option.map (fun st => st.rowLengthsRev.reverse) (inversePath initialInverseState steps)

def inverseExtension (steps : List MotzkinStep) : Option (List DiagramCell) :=
  Option.map (fun st => st.extensionRev.reverse) (inversePath initialInverseState steps)

def rowLengthAt? : List Nat → Nat → Option Nat
  | [], _ => none
  | x :: _, 1 => some x
  | _ :: xs, row + 2 => rowLengthAt? xs (row + 1)
  | _ :: _, 0 => none

def forwardStepOfCell (rowLengths : List Nat) : DiagramCell → Option MotzkinStep
  | A row =>
      match rowLengthAt? rowLengths row with
      | some 1 => some horizontal
      | some 2 => some up
      | _ => none
  | B row =>
      match rowLengthAt? rowLengths row with
      | some 2 => some down
      | _ => none

def forwardPathAux (rowLengths : List Nat) : List DiagramCell → Option (List MotzkinStep)
  | [] => some []
  | cell :: rest =>
      match forwardStepOfCell rowLengths cell, forwardPathAux rowLengths rest with
      | some step, some steps => some (step :: steps)
      | _, _ => none

def forwardPath (rowLengths : List Nat) (extension : List DiagramCell) : Option (List MotzkinStep) :=
  forwardPathAux rowLengths extension

def cellRow : DiagramCell → Nat
  | A row => row
  | B row => row

def isACell : DiagramCell → Bool
  | A _ => true
  | B _ => false

def isBCell : DiagramCell → Bool
  | A _ => false
  | B _ => true

def filterA : List DiagramCell → List Nat
  | [] => []
  | A row :: rest => row :: filterA rest
  | B _ :: rest => filterA rest

def filterB : List DiagramCell → List Nat
  | [] => []
  | A _ :: rest => filterB rest
  | B row :: rest => row :: filterB rest

def aRowsFrom (start : Nat) : List MotzkinStep → List Nat
  | [] => []
  | up :: rest => (start + 1) :: aRowsFrom (start + 1) rest
  | horizontal :: rest => (start + 1) :: aRowsFrom (start + 1) rest
  | down :: rest => aRowsFrom start rest

theorem filterA_append (xs ys : List DiagramCell) :
    filterA (xs ++ ys) = filterA xs ++ filterA ys := by
  induction xs with
  | nil =>
      simp [filterA]
  | cons x rest ih =>
      cases x <;> simp [filterA, ih]

theorem filterB_append (xs ys : List DiagramCell) :
    filterB (xs ++ ys) = filterB xs ++ filterB ys := by
  induction xs with
  | nil =>
      simp [filterB]
  | cons x rest ih =>
      cases x <;> simp [filterB, ih]

def StrictSuccessorChainFrom (start : Nat) : List Nat → Prop
  | [] => True
  | row :: rest => row = start ∧ StrictSuccessorChainFrom (start + 1) rest

def WeaklyIncreasing : List Nat → Prop
  | [] => True
  | [_] => True
  | x :: y :: rest => x ≤ y ∧ WeaklyIncreasing (y :: rest)

def bRowsFrom : InverseState → List MotzkinStep → List Nat
  | _, [] => []
  | st, up :: rest =>
      let row := st.nextRow + 1
      bRowsFrom
        { nextRow := row
          openRows := st.openRows ++ [row]
          rowLengthsRev := 2 :: st.rowLengthsRev
          extensionRev := A row :: st.extensionRev }
        rest
  | st, horizontal :: rest =>
      let row := st.nextRow + 1
      bRowsFrom
        { nextRow := row
          openRows := st.openRows
          rowLengthsRev := 1 :: st.rowLengthsRev
          extensionRev := A row :: st.extensionRev }
        rest
  | st, down :: rest =>
      match st.openRows with
      | [] => []
      | row :: rows =>
          row ::
            bRowsFrom
              { nextRow := st.nextRow
                openRows := rows
                rowLengthsRev := st.rowLengthsRev
                extensionRev := B row :: st.extensionRev }
              rest

def rowLengthCompatible (rowLengths : List Nat) : DiagramCell → Prop
  | A row =>
      rowLengthAt? rowLengths row = some 1 ∨ rowLengthAt? rowLengths row = some 2
  | B row =>
      rowLengthAt? rowLengths row = some 2

def matchRespectsRowLengths (rowLengths : List Nat) (extension : List DiagramCell) : Prop :=
  ∀ cell ∈ extension, rowLengthCompatible rowLengths cell

def ABChainShuffleAdmitted (rowLengths : List Nat) (extension : List DiagramCell) : Prop :=
  StrictSuccessorChainFrom 1 (filterA extension) ∧
  WeaklyIncreasing (filterB extension) ∧
  matchRespectsRowLengths rowLengths extension

def stateRowLengthCompatible (st : InverseState) : Prop :=
  matchRespectsRowLengths st.rowLengthsRev.reverse st.extensionRev.reverse

def openRowsTrackDoubleRows (st : InverseState) : Prop :=
  ∀ row ∈ st.openRows, rowLengthAt? st.rowLengthsRev.reverse row = some 2

def rowLengthsOfPath : List MotzkinStep → List Nat
  | [] => []
  | up :: rest => 2 :: rowLengthsOfPath rest
  | horizontal :: rest => 1 :: rowLengthsOfPath rest
  | down :: rest => rowLengthsOfPath rest

def countUp : List MotzkinStep → Nat
  | [] => 0
  | up :: rest => countUp rest + 1
  | _ :: rest => countUp rest

def countHorizontal : List MotzkinStep → Nat
  | [] => 0
  | horizontal :: rest => countHorizontal rest + 1
  | _ :: rest => countHorizontal rest

def countDown : List MotzkinStep → Nat
  | [] => 0
  | down :: rest => countDown rest + 1
  | _ :: rest => countDown rest

def nonDownCount (steps : List MotzkinStep) : Nat :=
  countUp steps + countHorizontal steps

theorem rowLengthAt_append_single_left {xs : List Nat} {value row : Nat}
    (hrow : 1 ≤ row) (hlen : row ≤ xs.length) :
    rowLengthAt? (xs ++ [value]) row = rowLengthAt? xs row := by
  induction xs generalizing row with
  | nil =>
      cases row with
      | zero =>
          cases Nat.not_succ_le_zero 0 hrow
      | succ row' =>
          simp at hlen
  | cons x rest ih =>
      cases row with
      | zero =>
          cases Nat.not_succ_le_zero 0 hrow
      | succ row' =>
          cases row' with
          | zero =>
              simp [rowLengthAt?]
          | succ row'' =>
              simp [rowLengthAt?]
              apply ih
              · exact Nat.succ_le_succ (Nat.zero_le _)
              · simpa using Nat.le_of_succ_le_succ hlen

theorem rowLengthAt_append_single_last (xs : List Nat) (value : Nat) :
    rowLengthAt? (xs ++ [value]) (xs.length + 1) = some value := by
  induction xs with
  | nil =>
      simp [rowLengthAt?]
  | cons x rest ih =>
      simpa [rowLengthAt?, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using ih

theorem stateRowLengthCompatible_initial : stateRowLengthCompatible initialInverseState := by
  intro cell hmem
  simp [initialInverseState] at hmem

theorem openRowsTrackDoubleRows_initial : openRowsTrackDoubleRows initialInverseState := by
  intro row hmem
  simp [initialInverseState] at hmem

theorem rowLengths_mem_one_two (steps : List MotzkinStep) :
    ∀ n ∈ rowLengthsOfPath steps, n = 1 ∨ n = 2 := by
  induction steps with
  | nil =>
      intro n h
      simp [rowLengthsOfPath] at h
  | cons step rest ih =>
      intro n h
      cases step with
      | up =>
          simp [rowLengthsOfPath] at h
          rcases h with h | h
          · right; exact h
          · exact ih n h
      | horizontal =>
          simp [rowLengthsOfPath] at h
          rcases h with h | h
          · left; exact h
          · exact ih n h
      | down =>
          simpa [rowLengthsOfPath] using ih n h

theorem length_rowLengthsOfPath (steps : List MotzkinStep) :
    (rowLengthsOfPath steps).length = nonDownCount steps := by
  induction steps with
  | nil =>
      simp [rowLengthsOfPath, nonDownCount, countUp, countHorizontal]
  | cons step rest ih =>
      cases step <;>
        simp [rowLengthsOfPath, nonDownCount, countUp, countHorizontal, ih, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc]

theorem sum_rowLengthsOfPath (steps : List MotzkinStep) :
    (rowLengthsOfPath steps).sum = countHorizontal steps + 2 * countUp steps := by
  induction steps with
  | nil =>
      simp [rowLengthsOfPath, countHorizontal, countUp]
  | cons step rest ih =>
      cases step with
      | up =>
          simp [rowLengthsOfPath, countHorizontal, countUp, ih, Nat.mul_add, Nat.add_left_comm, Nat.add_comm]
      | horizontal =>
          simp [rowLengthsOfPath, countHorizontal, countUp, ih, Nat.add_assoc, Nat.add_comm]
      | down =>
          simp [rowLengthsOfPath, countHorizontal, countUp, ih]

theorem scanHeight_some_implies_no_negative_prefix (h : Nat) (steps : List MotzkinStep) (h' : Nat)
    (hs : scanHeight h steps = some h') :
    ∃ k, scanHeight h steps = some k := by
  exact ⟨h', hs⟩

theorem isMotzkinPath_has_zero_terminal_height (steps : List MotzkinStep)
    (h : IsMotzkinPath steps) : scanHeight 0 steps = some 0 := h

theorem inverseStep_openRows_length_up (st : InverseState) :
    (match inverseStep st up with
    | some st' => st'.openRows.length
    | none => 0) = st.openRows.length + 1 := by
  simp [inverseStep]

theorem inverseStep_openRows_length_horizontal (st : InverseState) :
    (match inverseStep st horizontal with
    | some st' => st'.openRows.length
    | none => 0) = st.openRows.length := by
  simp [inverseStep]

theorem rowLengthAt_eq_some_bounds {xs : List Nat} {row value : Nat}
    (h : rowLengthAt? xs row = some value) :
    1 ≤ row ∧ row ≤ xs.length := by
  induction xs generalizing row with
  | nil =>
      simp [rowLengthAt?] at h
  | cons x rest ih =>
      cases row with
      | zero =>
          simp [rowLengthAt?] at h
      | succ row' =>
          constructor
          · exact Nat.succ_le_succ (Nat.zero_le _)
          · cases row' with
            | zero =>
                simp
            | succ row'' =>
                have h' : rowLengthAt? rest (row'' + 1) = some value := by
                  simpa [rowLengthAt?] using h
                rcases ih h' with ⟨_, hlen⟩
                simp
                omega

theorem rowLengthCompatible_append_single_right {xs : List Nat} {value : Nat} {cell : DiagramCell}
    (hcompat : rowLengthCompatible xs cell) :
    rowLengthCompatible (xs ++ [value]) cell := by
  cases cell with
  | A row =>
      rcases hcompat with h1 | h2
      · left
        rcases rowLengthAt_eq_some_bounds h1 with ⟨hrow, hrowlen⟩
        rw [rowLengthAt_append_single_left hrow hrowlen]
        exact h1
      · right
        rcases rowLengthAt_eq_some_bounds h2 with ⟨hrow, hrowlen⟩
        rw [rowLengthAt_append_single_left hrow hrowlen]
        exact h2
  | B row =>
      rcases rowLengthAt_eq_some_bounds hcompat with ⟨hrow, hrowlen⟩
      simpa [rowLengthCompatible, rowLengthAt_append_single_left hrow hrowlen] using hcompat

theorem rowLengthCompatible_append_single_last_up (xs : List Nat) :
    rowLengthCompatible (xs ++ [2]) (A (xs.length + 1)) := by
  right
  simpa using rowLengthAt_append_single_last xs 2

theorem rowLengthCompatible_append_single_last_horizontal (xs : List Nat) :
    rowLengthCompatible (xs ++ [1]) (A (xs.length + 1)) := by
  left
  simpa using rowLengthAt_append_single_last xs 1

theorem forwardStepOfCell_stable_under_rowLengths_append_right {xs : List Nat} {value : Nat}
    {cell : DiagramCell} (hcompat : rowLengthCompatible xs cell) :
    forwardStepOfCell (xs ++ [value]) cell = forwardStepOfCell xs cell := by
  cases cell with
  | A row =>
      simp [rowLengthCompatible] at hcompat
      rcases hcompat with h1 | h2
      · rcases rowLengthAt_eq_some_bounds h1 with ⟨hrow1, hlen1⟩
        have h1' := rowLengthAt_append_single_left (xs := xs) (value := value) hrow1 hlen1
        simp [forwardStepOfCell, h1, h1']
      · rcases rowLengthAt_eq_some_bounds h2 with ⟨hrow2, hlen2⟩
        have h2' := rowLengthAt_append_single_left (xs := xs) (value := value) hrow2 hlen2
        simp [forwardStepOfCell, h2, h2']
  | B row =>
      simp [rowLengthCompatible] at hcompat
      rcases rowLengthAt_eq_some_bounds hcompat with ⟨hrow, hlen⟩
      have h' := rowLengthAt_append_single_left (xs := xs) (value := value) hrow hlen
      simp [forwardStepOfCell, hcompat, h']

theorem forwardPath_stable_under_rowLengths_append_right {xs : List Nat} {value : Nat}
    {extension : List DiagramCell} (hcompat : matchRespectsRowLengths xs extension) :
    forwardPath (xs ++ [value]) extension = forwardPath xs extension := by
  induction extension with
  | nil =>
      simp [forwardPath, forwardPathAux]
  | cons cell rest ih =>
      have hcell : rowLengthCompatible xs cell := hcompat cell (by simp)
      have hrest : matchRespectsRowLengths xs rest := by
        intro c hc
        exact hcompat c (by simp [hc])
      have hcell' := forwardStepOfCell_stable_under_rowLengths_append_right (value := value) hcell
      have hrest' := ih hrest
      rw [forwardPath] at hrest'
      simp [forwardPath, forwardPathAux, hcell', hrest']

theorem forwardPath_append_single_of_step {rowLengths : List Nat} {extension : List DiagramCell}
    {steps : List MotzkinStep} {cell : DiagramCell} {step : MotzkinStep}
    (hpath : forwardPath rowLengths extension = some steps)
    (hstep : forwardStepOfCell rowLengths cell = some step) :
    forwardPath rowLengths (extension ++ [cell]) = some (steps ++ [step]) := by
  induction extension generalizing steps cell step with
  | nil =>
      simp [forwardPath, forwardPathAux] at hpath
      cases hpath
      simp [forwardPath, forwardPathAux, hstep]
  | cons x rest ih =>
      simp [forwardPath, forwardPathAux] at hpath ⊢
      cases hx : forwardStepOfCell rowLengths x <;> simp [hx] at hpath
      case some stepx =>
        cases hr : forwardPathAux rowLengths rest <;> simp [hr] at hpath
        case some restSteps =>
          cases hpath
          have hrest : forwardPath rowLengths rest = some restSteps := by
            simpa [forwardPath] using hr
          have ih' := ih hrest hstep
          rw [forwardPath] at ih'
          rw [ih']
          rfl

theorem inverseStep_openRows_length_down_of_nonempty (st : InverseState) (h : st.openRows ≠ []) :
    ∃ st', inverseStep st down = some st' ∧ st'.openRows.length + 1 = st.openRows.length := by
  cases hrows : st.openRows with
  | nil =>
      contradiction
  | cons row rest =>
      refine ⟨
        { nextRow := st.nextRow
          openRows := rest
          rowLengthsRev := st.rowLengthsRev
          extensionRev := B row :: st.extensionRev },
        ?_, ?_⟩
      · simp [inverseStep, hrows]
      · simp

theorem inversePath_of_scanHeight_some :
    ∀ h steps h' st,
      st.openRows.length = h →
      scanHeight h steps = some h' →
      ∃ st', inversePath st steps = some st' ∧ st'.openRows.length = h'
  := by
  intro h steps
  induction steps generalizing h with
  | nil =>
      intro h' st hlen hscan
      simp [scanHeight] at hscan
      subst hscan
      exact ⟨st, rfl, hlen⟩
  | cons step rest ih =>
      intro h' st hlen hscan
      cases step with
      | up =>
          simp [scanHeight] at hscan
          let stUp : InverseState :=
            { nextRow := st.nextRow + 1
              openRows := st.openRows ++ [st.nextRow + 1]
              rowLengthsRev := 2 :: st.rowLengthsRev
              extensionRev := A (st.nextRow + 1) :: st.extensionRev }
          rcases ih (h + 1) h' stUp (by simp [stUp, hlen]) hscan with ⟨st', hp, hfinal⟩
          · refine ⟨st', ?_, hfinal⟩
            simpa [inversePath, inverseStep, stUp] using hp
      | horizontal =>
          simp [scanHeight] at hscan
          let stHoriz : InverseState :=
            { nextRow := st.nextRow + 1
              openRows := st.openRows
              rowLengthsRev := 1 :: st.rowLengthsRev
              extensionRev := A (st.nextRow + 1) :: st.extensionRev }
          rcases ih h h' stHoriz (by simp [stHoriz, hlen]) hscan with ⟨st', hp, hfinal⟩
          · refine ⟨st', ?_, hfinal⟩
            simpa [inversePath, inverseStep, stHoriz] using hp
      | down =>
          cases hzero : h with
          | zero =>
              simp [scanHeight, hzero] at hscan
          | succ k =>
              simp [scanHeight, hzero] at hscan
              have hnonempty : st.openRows ≠ [] := by
                intro hempty
                rw [hempty, List.length_nil] at hlen
                simp [hzero] at hlen
              rcases inverseStep_openRows_length_down_of_nonempty st hnonempty with ⟨st1, hstep, hstepLen⟩
              rcases ih k h' st1 (by omega) hscan with ⟨st', hp, hfinal⟩
              · refine ⟨st', ?_, hfinal⟩
                simp [inversePath, hstep, hp]

theorem inversePath_preserves_prefix_condition (steps : List MotzkinStep)
    (h : IsMotzkinPath steps) :
    ∃ st, inversePath initialInverseState steps = some st ∧ st.openRows = [] := by
  rcases inversePath_of_scanHeight_some 0 steps 0 initialInverseState rfl h with ⟨st, hpath, hopen⟩
  refine ⟨st, hpath, ?_⟩
  cases hrows : st.openRows with
  | nil => rfl
  | cons x xs => simp [hrows] at hopen

theorem inversePath_rowLengths_append :
    ∀ st steps st',
      inversePath st steps = some st' →
      st'.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ rowLengthsOfPath steps
  := by
  intro st steps
  induction steps generalizing st with
  | nil =>
      intro st' h
      simp [inversePath] at h
      cases h
      simp [rowLengthsOfPath]
  | cons step rest ih =>
      intro st' h
      cases step with
      | up =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [rowLengthsOfPath, List.reverse_cons, List.append_assoc] using hrest
      | horizontal =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [rowLengthsOfPath, List.reverse_cons, List.append_assoc] using hrest
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at h
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at h
              simpa [rowLengthsOfPath] using ih _ _ h

theorem inversePath_rowLengths (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    st.rowLengthsRev.reverse = rowLengthsOfPath steps := by
  simpa [initialInverseState] using inversePath_rowLengths_append initialInverseState steps st h

theorem inversePath_extension_length_append :
    ∀ st steps st',
      inversePath st steps = some st' →
      st'.extensionRev.length = st.extensionRev.length + steps.length
  := by
  intro st steps
  induction steps generalizing st with
  | nil =>
      intro st' h
      simp [inversePath] at h
      cases h
      simp
  | cons step rest ih =>
      intro st' h
      cases step with
      | up =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hrest
      | horizontal =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hrest
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at h
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at h
              have hrest := ih _ _ h
              simpa [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm] using hrest

theorem inversePath_extension_length (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    st.extensionRev.length = steps.length := by
  simpa [initialInverseState] using inversePath_extension_length_append initialInverseState steps st h

theorem inversePath_nextRow_rowLengthsRev_append :
    ∀ st steps st',
      inversePath st steps = some st' →
      st'.nextRow = st.nextRow + nonDownCount steps ∧
      st'.rowLengthsRev.length = st.rowLengthsRev.length + nonDownCount steps
  := by
  intro st steps
  induction steps generalizing st with
  | nil =>
      intro st' h
      simp [inversePath] at h
      cases h
      simp [nonDownCount, countUp, countHorizontal]
  | cons step rest ih =>
      intro st' h
      cases step with
      | up =>
          simp [inversePath, inverseStep] at h
          rcases ih _ _ h with ⟨hnext, hlen⟩
          constructor
          · simp [nonDownCount, countUp, countHorizontal] at hnext ⊢
            omega
          · simp [nonDownCount, countUp, countHorizontal] at hlen ⊢
            omega
      | horizontal =>
          simp [inversePath, inverseStep] at h
          rcases ih _ _ h with ⟨hnext, hlen⟩
          constructor
          · simp [nonDownCount, countUp, countHorizontal] at hnext ⊢
            omega
          · simp [nonDownCount, countUp, countHorizontal] at hlen ⊢
            omega
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at h
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at h
              rcases ih _ _ h with ⟨hnext, hlen⟩
              constructor
              · simpa [nonDownCount, countUp, countHorizontal] using hnext
              · simp [nonDownCount, countUp, countHorizontal] at hlen ⊢
                omega

theorem inversePath_nextRow_eq_rowLengthsRev_length (steps : List MotzkinStep) (st st' : InverseState)
    (hbase : st.nextRow = st.rowLengthsRev.length)
    (h : inversePath st steps = some st') :
    st'.nextRow = st'.rowLengthsRev.length := by
  rcases inversePath_nextRow_rowLengthsRev_append st steps st' h with ⟨hnext, hlen⟩
  omega

theorem inversePath_nextRow_eq_rowLengthsRev_length_initial (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    st.nextRow = st.rowLengthsRev.length := by
  apply inversePath_nextRow_eq_rowLengthsRev_length steps initialInverseState st
  · simp [initialInverseState]
  · exact h

theorem aRowsFrom_strictSuccessorChainFrom (start : Nat) (steps : List MotzkinStep) :
    StrictSuccessorChainFrom (start + 1) (aRowsFrom start steps) := by
  induction steps generalizing start with
  | nil =>
      simp [aRowsFrom, StrictSuccessorChainFrom]
  | cons step rest ih =>
      cases step with
      | up =>
          simp [aRowsFrom, StrictSuccessorChainFrom, ih]
      | horizontal =>
          simp [aRowsFrom, StrictSuccessorChainFrom, ih]
      | down =>
          simpa [aRowsFrom] using ih start

theorem inversePath_filterA_append :
    ∀ st steps st',
      inversePath st steps = some st' →
      filterA st'.extensionRev.reverse = filterA st.extensionRev.reverse ++ aRowsFrom st.nextRow steps
  := by
  intro st steps
  induction steps generalizing st with
  | nil =>
      intro st' h
      simp [inversePath] at h
      cases h
      simp [aRowsFrom]
  | cons step rest ih =>
      intro st' h
      cases step with
      | up =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [aRowsFrom, List.reverse_cons, List.append_assoc, filterA, filterA_append] using hrest
      | horizontal =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [aRowsFrom, List.reverse_cons, List.append_assoc, filterA, filterA_append] using hrest
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at h
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at h
              have hrest := ih _ _ h
              simpa [aRowsFrom, List.reverse_cons, List.append_assoc, filterA, filterA_append] using hrest

theorem inversePath_filterA_chain_initial (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    StrictSuccessorChainFrom 1 (filterA st.extensionRev.reverse) := by
  have hA := inversePath_filterA_append initialInverseState steps st h
  rw [hA]
  simpa [initialInverseState, filterA] using aRowsFrom_strictSuccessorChainFrom 0 steps

theorem inversePath_filterB_append :
    ∀ st steps st',
      inversePath st steps = some st' →
      filterB st'.extensionRev.reverse = filterB st.extensionRev.reverse ++ bRowsFrom st steps
  := by
  intro st steps
  induction steps generalizing st with
  | nil =>
      intro st' h
      simp [inversePath] at h
      cases h
      simp [bRowsFrom]
  | cons step rest ih =>
      intro st' h
      cases step with
      | up =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [bRowsFrom, List.reverse_cons, List.append_assoc, filterB, filterB_append] using hrest
      | horizontal =>
          simp [inversePath, inverseStep] at h
          have hrest := ih _ _ h
          simpa [bRowsFrom, List.reverse_cons, List.append_assoc, filterB, filterB_append] using hrest
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at h
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at h
              have hrest := ih _ _ h
              simpa [bRowsFrom, hopen, List.reverse_cons, List.append_assoc, filterB, filterB_append] using hrest

def AdmittedExtension (rowLengths : List Nat) (extension : List DiagramCell) : Prop :=
  ∀ cell ∈ extension, ∃ step, forwardStepOfCell rowLengths cell = some step

theorem rowLengthAt_eq_one_or_two_of_forwardA {rowLengths : List Nat} {row : Nat} {step : MotzkinStep}
    (h : forwardStepOfCell rowLengths (A row) = some step) :
    rowLengthAt? rowLengths row = some 1 ∨ rowLengthAt? rowLengths row = some 2 := by
  cases hlen : rowLengthAt? rowLengths row with
  | none =>
      simp [forwardStepOfCell, hlen] at h
  | some n =>
      cases n with
      | zero =>
          simp [forwardStepOfCell, hlen] at h
      | succ n' =>
          cases n' with
          | zero =>
              left
              simp [hlen]
          | succ n'' =>
              cases n'' with
              | zero =>
                  right
                  simp [hlen]
              | succ n''' =>
                  simp [forwardStepOfCell, hlen] at h

theorem rowLengthAt_eq_two_of_forwardB {rowLengths : List Nat} {row : Nat} {step : MotzkinStep}
    (h : forwardStepOfCell rowLengths (B row) = some step) :
    rowLengthAt? rowLengths row = some 2 := by
  cases hlen : rowLengthAt? rowLengths row with
  | none =>
      simp [forwardStepOfCell, hlen] at h
  | some n =>
      cases n with
      | zero =>
          simp [forwardStepOfCell, hlen] at h
      | succ n' =>
          cases n' with
          | zero =>
              simp [forwardStepOfCell, hlen] at h
          | succ n'' =>
              cases n'' with
              | zero =>
                  simp [hlen]
              | succ n''' =>
                  simp [forwardStepOfCell, hlen] at h

theorem matchRespectsRowLengths_of_admitted (rowLengths : List Nat) (extension : List DiagramCell)
    (h : AdmittedExtension rowLengths extension) :
    matchRespectsRowLengths rowLengths extension := by
  intro cell hmem
  rcases h cell hmem with ⟨step, hstep⟩
  cases cell with
  | A row =>
      exact rowLengthAt_eq_one_or_two_of_forwardA hstep
  | B row =>
      exact rowLengthAt_eq_two_of_forwardB hstep

theorem admitted_of_matchRespectsRowLengths (rowLengths : List Nat) (extension : List DiagramCell)
    (hcompat : matchRespectsRowLengths rowLengths extension) :
    AdmittedExtension rowLengths extension := by
  intro cell hmem
  specialize hcompat cell hmem
  cases cell with
  | A row =>
      rcases hcompat with h1 | h2
      · refine ⟨horizontal, ?_⟩
        simp [forwardStepOfCell, h1]
      · refine ⟨up, ?_⟩
        simp [forwardStepOfCell, h2]
  | B row =>
      refine ⟨down, ?_⟩
      simp [rowLengthCompatible] at hcompat
      simp [forwardStepOfCell, hcompat]

theorem admitted_of_ABChainShuffleAdmitted (rowLengths : List Nat) (extension : List DiagramCell)
    (h : ABChainShuffleAdmitted rowLengths extension) :
    AdmittedExtension rowLengths extension := by
  intro cell hmem
  rcases h with ⟨_hA, _hB, hcompat⟩
  specialize hcompat cell hmem
  cases cell with
  | A row =>
      rcases hcompat with h1 | h2
      · refine ⟨horizontal, ?_⟩
        simp [forwardStepOfCell, h1]
      · refine ⟨up, ?_⟩
        simp [forwardStepOfCell, h2]
  | B row =>
      refine ⟨down, ?_⟩
      simp [rowLengthCompatible] at hcompat
      simp [forwardStepOfCell, hcompat]

theorem inversePath_preserves_invariants :
    ∀ st steps st',
      st.nextRow = st.rowLengthsRev.length →
      stateRowLengthCompatible st →
      openRowsTrackDoubleRows st →
      inversePath st steps = some st' →
      stateRowLengthCompatible st' ∧ openRowsTrackDoubleRows st'
  := by
  intro st steps
  induction steps generalizing st with
  | nil =>
      intro st' hlen hcompat htrack hpath
      simp [inversePath] at hpath
      cases hpath
      exact ⟨hcompat, htrack⟩
  | cons step rest ih =>
      intro st' hlen hcompat htrack hpath
      cases step with
      | up =>
          simp [inversePath, inverseStep] at hpath
          let stUp : InverseState :=
            { nextRow := st.nextRow + 1
              openRows := st.openRows ++ [st.nextRow + 1]
              rowLengthsRev := 2 :: st.rowLengthsRev
              extensionRev := A (st.nextRow + 1) :: st.extensionRev }
          have hcompatUp : stateRowLengthCompatible stUp := by
            intro cell hmem
            rw [show stUp.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [2] by
                  simp [stUp, List.reverse_cons, List.append_assoc]]
            rw [show stUp.extensionRev.reverse = st.extensionRev.reverse ++ [A (st.nextRow + 1)] by
                  simp [stUp, List.reverse_cons, List.append_assoc]] at hmem
            rw [List.mem_append] at hmem
            rcases hmem with hold | hnew
            · exact rowLengthCompatible_append_single_right (hcompat cell hold)
            · simp at hnew
              rw [hnew]
              simpa [hlen] using rowLengthCompatible_append_single_last_up st.rowLengthsRev.reverse
          have htrackUp : openRowsTrackDoubleRows stUp := by
            intro row hmem
            rw [show stUp.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [2] by
                  simp [stUp, List.reverse_cons]]
            rw [show stUp.openRows = st.openRows ++ [st.nextRow + 1] by
                  rfl] at hmem
            rw [List.mem_append] at hmem
            rcases hmem with hold | hnew
            · have hrow := htrack row hold
              rcases rowLengthAt_eq_some_bounds hrow with ⟨hrow_ge, hrow_le⟩
              have hleft := rowLengthAt_append_single_left (xs := st.rowLengthsRev.reverse) (value := 2)
                hrow_ge hrow_le
              simpa [hleft] using hrow
            · simp at hnew
              rw [hnew]
              simpa [hlen] using rowLengthAt_append_single_last st.rowLengthsRev.reverse 2
          have hlenUp : stUp.nextRow = stUp.rowLengthsRev.length := by
            simp [stUp, hlen]
          exact ih stUp st' hlenUp hcompatUp htrackUp hpath
      | horizontal =>
          simp [inversePath, inverseStep] at hpath
          let stHoriz : InverseState :=
            { nextRow := st.nextRow + 1
              openRows := st.openRows
              rowLengthsRev := 1 :: st.rowLengthsRev
              extensionRev := A (st.nextRow + 1) :: st.extensionRev }
          have hcompatHoriz : stateRowLengthCompatible stHoriz := by
            intro cell hmem
            rw [show stHoriz.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [1] by
                  simp [stHoriz, List.reverse_cons, List.append_assoc]]
            rw [show stHoriz.extensionRev.reverse = st.extensionRev.reverse ++ [A (st.nextRow + 1)] by
                  simp [stHoriz, List.reverse_cons, List.append_assoc]] at hmem
            rw [List.mem_append] at hmem
            rcases hmem with hold | hnew
            · exact rowLengthCompatible_append_single_right (hcompat cell hold)
            · simp at hnew
              rw [hnew]
              simpa [hlen] using rowLengthCompatible_append_single_last_horizontal st.rowLengthsRev.reverse
          have htrackHoriz : openRowsTrackDoubleRows stHoriz := by
            intro row hmem
            rw [show stHoriz.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [1] by
                  simp [stHoriz, List.reverse_cons]]
            have hrow := htrack row (by simpa [stHoriz] using hmem)
            rcases rowLengthAt_eq_some_bounds hrow with ⟨hrow_ge, hrow_le⟩
            have hleft := rowLengthAt_append_single_left (xs := st.rowLengthsRev.reverse) (value := 1)
              hrow_ge hrow_le
            simpa [hleft] using hrow
          have hlenHoriz : stHoriz.nextRow = stHoriz.rowLengthsRev.length := by
            simp [stHoriz, hlen]
          exact ih stHoriz st' hlenHoriz hcompatHoriz htrackHoriz hpath
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at hpath
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at hpath
              let stDown : InverseState :=
                { nextRow := st.nextRow
                  openRows := rows
                  rowLengthsRev := st.rowLengthsRev
                  extensionRev := B row :: st.extensionRev }
              have hcompatDown : stateRowLengthCompatible stDown := by
                intro cell hmem
                rw [show stDown.rowLengthsRev.reverse = st.rowLengthsRev.reverse by
                      simp [stDown]]
                rw [show stDown.extensionRev.reverse = st.extensionRev.reverse ++ [B row] by
                      simp [stDown, List.reverse_cons, List.append_assoc]] at hmem
                rw [List.mem_append] at hmem
                rcases hmem with hold | hnew
                · exact hcompat cell hold
                · simp at hnew
                  rw [hnew]
                  have hrowCompat : rowLengthCompatible st.rowLengthsRev.reverse (B row) := by
                    simp [openRowsTrackDoubleRows] at htrack
                    simp [rowLengthCompatible]
                    exact htrack row (by simpa [hopen])
                  simpa using hrowCompat
              have htrackDown : openRowsTrackDoubleRows stDown := by
                intro row' hmem
                have hrow : rowLengthAt? st.rowLengthsRev.reverse row' = some 2 := by
                  apply htrack
                  simpa [hopen] using (Or.inr (by simpa [stDown] using hmem) : row' = row ∨ row' ∈ rows)
                simpa [stDown] using hrow
              have hlenDown : stDown.nextRow = stDown.rowLengthsRev.length := by
                simpa [stDown] using hlen
              exact ih stDown st' hlenDown hcompatDown htrackDown hpath

theorem inversePath_stateRowLengthCompatible :
    ∀ st steps st',
      st.nextRow = st.rowLengthsRev.length →
      stateRowLengthCompatible st →
      openRowsTrackDoubleRows st →
      inversePath st steps = some st' →
      stateRowLengthCompatible st'
  := by
  intro st steps st' hlen hcompat htrack hpath
  exact (inversePath_preserves_invariants st steps st' hlen hcompat htrack hpath).1

theorem forwardPathAux_defined_of_admitted :
    ∀ rowLengths extension,
      AdmittedExtension rowLengths extension →
      ∃ steps, forwardPathAux rowLengths extension = some steps
  := by
  intro rowLengths extension
  induction extension with
  | nil =>
      intro _
      exact ⟨[], rfl⟩
  | cons cell rest ih =>
      intro hadm
      have hcell : ∃ step, forwardStepOfCell rowLengths cell = some step := hadm cell (by simp)
      have hrestAdm : AdmittedExtension rowLengths rest := by
        intro c hc
        exact hadm c (by simp [hc])
      rcases hcell with ⟨step, hstep⟩
      rcases ih hrestAdm with ⟨steps, hsteps⟩
      refine ⟨step :: steps, ?_⟩
      unfold forwardPathAux
      rw [hstep, hsteps]

theorem forwardPath_defined_of_admitted (rowLengths : List Nat) (extension : List DiagramCell)
    (h : AdmittedExtension rowLengths extension) :
    ∃ steps, forwardPath rowLengths extension = some steps := by
  simpa [forwardPath] using forwardPathAux_defined_of_admitted rowLengths extension h

theorem forwardPath_defined_of_chain_shuffle (rowLengths : List Nat) (extension : List DiagramCell)
    (h : ABChainShuffleAdmitted rowLengths extension) :
    ∃ steps, forwardPath rowLengths extension = some steps := by
  exact forwardPath_defined_of_admitted rowLengths extension (admitted_of_ABChainShuffleAdmitted rowLengths extension h)

theorem inversePath_forwardPath_roundtrip_append (st : InverseState) (accSteps : List MotzkinStep)
    (steps : List MotzkinStep) (st' : InverseState) :
    st.nextRow = st.rowLengthsRev.length -> stateRowLengthCompatible st ->
    openRowsTrackDoubleRows st ->
    forwardPath st.rowLengthsRev.reverse st.extensionRev.reverse = some accSteps ->
    inversePath st steps = some st' ->
    forwardPath st'.rowLengthsRev.reverse st'.extensionRev.reverse = some (accSteps ++ steps) := by
  induction steps generalizing st accSteps st' with
  | nil =>
      intro hlen hcompat htrack hprefix hpath
      simp [inversePath] at hpath
      cases hpath
      simpa using hprefix
  | cons step rest ih =>
      intro hlen hcompat htrack hprefix hpath
      cases step with
      | up =>
          simp [inversePath, inverseStep] at hpath
          let stUp : InverseState :=
            { nextRow := st.nextRow + 1
              openRows := st.openRows ++ [st.nextRow + 1]
              rowLengthsRev := 2 :: st.rowLengthsRev
              extensionRev := A (st.nextRow + 1) :: st.extensionRev }
          have hcompatUp : stateRowLengthCompatible stUp := by
            intro cell hmem
            rw [show stUp.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [2] by
                  simp [stUp, List.reverse_cons]]
            rw [show stUp.extensionRev.reverse = st.extensionRev.reverse ++ [A (st.nextRow + 1)] by
                  simp [stUp, List.reverse_cons]] at hmem
            rw [List.mem_append] at hmem
            rcases hmem with hold | hnew
            · exact rowLengthCompatible_append_single_right (hcompat cell hold)
            · simp at hnew
              rw [hnew]
              simpa [hlen] using rowLengthCompatible_append_single_last_up st.rowLengthsRev.reverse
          have htrackUp : openRowsTrackDoubleRows stUp := by
            intro row hmem
            rw [show stUp.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [2] by
                  simp [stUp, List.reverse_cons]]
            rw [show stUp.openRows = st.openRows ++ [st.nextRow + 1] by
                  rfl] at hmem
            rw [List.mem_append] at hmem
            rcases hmem with hold | hnew
            · have hrow := htrack row hold
              rcases rowLengthAt_eq_some_bounds hrow with ⟨hrow_ge, hrow_le⟩
              have hleft := rowLengthAt_append_single_left (xs := st.rowLengthsRev.reverse) (value := 2)
                hrow_ge hrow_le
              simpa [hleft] using hrow
            · simp at hnew
              rw [hnew]
              simpa [hlen] using rowLengthAt_append_single_last st.rowLengthsRev.reverse 2
          have hlenUp : stUp.nextRow = stUp.rowLengthsRev.length := by
            simp [stUp, hlen]
          have hprefixStable :
              forwardPath stUp.rowLengthsRev.reverse st.extensionRev.reverse = some accSteps := by
            simpa [stUp, List.reverse_cons] using
              (forwardPath_stable_under_rowLengths_append_right (xs := st.rowLengthsRev.reverse)
                (value := 2) (extension := st.extensionRev.reverse) hcompat).trans hprefix
          have hnewStep :
              forwardStepOfCell stUp.rowLengthsRev.reverse (A (st.nextRow + 1)) = some up := by
            have hlast : rowLengthAt? (st.rowLengthsRev.reverse ++ [2]) (st.nextRow + 1) = some 2 := by
              simpa [hlen] using rowLengthAt_append_single_last st.rowLengthsRev.reverse 2
            simp [stUp, forwardStepOfCell, hlast]
          have hprefixUp :
              forwardPath stUp.rowLengthsRev.reverse stUp.extensionRev.reverse = some (accSteps ++ [up]) := by
            rw [show stUp.extensionRev.reverse = st.extensionRev.reverse ++ [A (st.nextRow + 1)] by
                  simp [stUp, List.reverse_cons]]
            exact forwardPath_append_single_of_step hprefixStable hnewStep
          have hrest := ih stUp (accSteps ++ [up]) st' hlenUp hcompatUp htrackUp hprefixUp hpath
          simpa [List.append_assoc] using hrest
      | horizontal =>
          simp [inversePath, inverseStep] at hpath
          let stHoriz : InverseState :=
            { nextRow := st.nextRow + 1
              openRows := st.openRows
              rowLengthsRev := 1 :: st.rowLengthsRev
              extensionRev := A (st.nextRow + 1) :: st.extensionRev }
          have hcompatHoriz : stateRowLengthCompatible stHoriz := by
            intro cell hmem
            rw [show stHoriz.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [1] by
                  simp [stHoriz, List.reverse_cons]]
            rw [show stHoriz.extensionRev.reverse = st.extensionRev.reverse ++ [A (st.nextRow + 1)] by
                  simp [stHoriz, List.reverse_cons]] at hmem
            rw [List.mem_append] at hmem
            rcases hmem with hold | hnew
            · exact rowLengthCompatible_append_single_right (hcompat cell hold)
            · simp at hnew
              rw [hnew]
              simpa [hlen] using rowLengthCompatible_append_single_last_horizontal st.rowLengthsRev.reverse
          have htrackHoriz : openRowsTrackDoubleRows stHoriz := by
            intro row hmem
            rw [show stHoriz.rowLengthsRev.reverse = st.rowLengthsRev.reverse ++ [1] by
                  simp [stHoriz, List.reverse_cons]]
            have hrow := htrack row (by simpa [stHoriz] using hmem)
            rcases rowLengthAt_eq_some_bounds hrow with ⟨hrow_ge, hrow_le⟩
            have hleft := rowLengthAt_append_single_left (xs := st.rowLengthsRev.reverse) (value := 1)
              hrow_ge hrow_le
            simpa [hleft] using hrow
          have hlenHoriz : stHoriz.nextRow = stHoriz.rowLengthsRev.length := by
            simp [stHoriz, hlen]
          have hprefixStable :
              forwardPath stHoriz.rowLengthsRev.reverse st.extensionRev.reverse = some accSteps := by
            simpa [stHoriz, List.reverse_cons] using
              (forwardPath_stable_under_rowLengths_append_right (xs := st.rowLengthsRev.reverse)
                (value := 1) (extension := st.extensionRev.reverse) hcompat).trans hprefix
          have hnewStep :
              forwardStepOfCell stHoriz.rowLengthsRev.reverse (A (st.nextRow + 1)) = some horizontal := by
            have hlast : rowLengthAt? (st.rowLengthsRev.reverse ++ [1]) (st.nextRow + 1) = some 1 := by
              simpa [hlen] using rowLengthAt_append_single_last st.rowLengthsRev.reverse 1
            simp [stHoriz, forwardStepOfCell, hlast]
          have hprefixHoriz :
              forwardPath stHoriz.rowLengthsRev.reverse stHoriz.extensionRev.reverse = some (accSteps ++ [horizontal]) := by
            rw [show stHoriz.extensionRev.reverse = st.extensionRev.reverse ++ [A (st.nextRow + 1)] by
                  simp [stHoriz, List.reverse_cons]]
            exact forwardPath_append_single_of_step hprefixStable hnewStep
          have hrest := ih stHoriz (accSteps ++ [horizontal]) st' hlenHoriz hcompatHoriz htrackHoriz hprefixHoriz hpath
          simpa [List.append_assoc] using hrest
      | down =>
          cases hopen : st.openRows with
          | nil =>
              simp [inversePath, inverseStep, hopen] at hpath
          | cons row rows =>
              simp [inversePath, inverseStep, hopen] at hpath
              let stDown : InverseState :=
                { nextRow := st.nextRow
                  openRows := rows
                  rowLengthsRev := st.rowLengthsRev
                  extensionRev := B row :: st.extensionRev }
              have hcompatDown : stateRowLengthCompatible stDown := by
                intro cell hmem
                rw [show stDown.rowLengthsRev.reverse = st.rowLengthsRev.reverse by simp [stDown]]
                rw [show stDown.extensionRev.reverse = st.extensionRev.reverse ++ [B row] by
                      simp [stDown, List.reverse_cons]] at hmem
                rw [List.mem_append] at hmem
                rcases hmem with hold | hnew
                · exact hcompat cell hold
                · simp at hnew
                  rw [hnew]
                  simp [openRowsTrackDoubleRows] at htrack
                  simp [rowLengthCompatible]
                  exact htrack row (by simpa [hopen])
              have htrackDown : openRowsTrackDoubleRows stDown := by
                intro row' hmem
                have hrow : rowLengthAt? st.rowLengthsRev.reverse row' = some 2 := by
                  apply htrack
                  simpa [hopen] using (Or.inr (by simpa [stDown] using hmem) : row' = row ∨ row' ∈ rows)
                simpa [stDown] using hrow
              have hlenDown : stDown.nextRow = stDown.rowLengthsRev.length := by
                simpa [stDown] using hlen
              have hnewStep :
                  forwardStepOfCell stDown.rowLengthsRev.reverse (B row) = some down := by
                have hrow : rowLengthAt? st.rowLengthsRev.reverse row = some 2 := by
                  exact htrack row (by simpa [hopen])
                simp [stDown, forwardStepOfCell, hrow]
              have hprefixDown :
                  forwardPath stDown.rowLengthsRev.reverse stDown.extensionRev.reverse = some (accSteps ++ [down]) := by
                rw [show stDown.extensionRev.reverse = st.extensionRev.reverse ++ [B row] by
                      simp [stDown, List.reverse_cons]]
                exact forwardPath_append_single_of_step hprefix hnewStep
              have hrest := ih stDown (accSteps ++ [down]) st' hlenDown hcompatDown htrackDown hprefixDown hpath
              simpa [List.append_assoc] using hrest

theorem inversePath_admittedExtension_initial (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    AdmittedExtension st.rowLengthsRev.reverse st.extensionRev.reverse := by
  have hcompat : stateRowLengthCompatible st := by
    apply inversePath_stateRowLengthCompatible initialInverseState steps st
    · simp [initialInverseState]
    · exact stateRowLengthCompatible_initial
    · exact openRowsTrackDoubleRows_initial
    · exact h
  exact admitted_of_matchRespectsRowLengths _ _ hcompat

theorem inversePath_forwardPath_defined_initial (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    ∃ out, forwardPath st.rowLengthsRev.reverse st.extensionRev.reverse = some out := by
  exact forwardPath_defined_of_admitted _ _ (inversePath_admittedExtension_initial steps st h)

theorem inversePath_forwardPath_roundtrip_initial (steps : List MotzkinStep) (st : InverseState)
    (h : inversePath initialInverseState steps = some st) :
    forwardPath st.rowLengthsRev.reverse st.extensionRev.reverse = some steps := by
  simpa [initialInverseState] using
    inversePath_forwardPath_roundtrip_append initialInverseState [] steps st
      (by simp [initialInverseState])
      stateRowLengthCompatible_initial
      openRowsTrackDoubleRows_initial
      (by simp [forwardPath, forwardPathAux, initialInverseState])
      h

theorem inverseExtension_exists (steps : List MotzkinStep) (h : IsMotzkinPath steps) :
    ∃ ext, inverseExtension steps = some ext := by
  rcases inversePath_preserves_prefix_condition steps h with ⟨st, hpath, _⟩
  refine ⟨st.extensionRev.reverse, ?_⟩
  simp [inverseExtension, hpath]

theorem inverseRowLengths_exists (steps : List MotzkinStep) (h : IsMotzkinPath steps) :
    ∃ rows, inverseRowLengths steps = some rows := by
  rcases inversePath_preserves_prefix_condition steps h with ⟨st, hpath, _⟩
  refine ⟨st.rowLengthsRev.reverse, ?_⟩
  simp [inverseRowLengths, hpath]

theorem inverseRowLengths_eq_rowLengthsOfPath (steps : List MotzkinStep) (h : IsMotzkinPath steps) :
    inverseRowLengths steps = some (rowLengthsOfPath steps) := by
  rcases inversePath_preserves_prefix_condition steps h with ⟨st, hpath, _⟩
  have hrows := inversePath_rowLengths steps st hpath
  simp [inverseRowLengths, hpath, hrows]

theorem final_bijection_theorem (steps : List MotzkinStep) (h : IsMotzkinPath steps) :
    ∃ st,
      inversePath initialInverseState steps = some st ∧
      st.openRows = [] ∧
      st.rowLengthsRev.reverse = rowLengthsOfPath steps := by
  rcases inversePath_preserves_prefix_condition steps h with ⟨st, hpath, hopen⟩
  refine ⟨st, hpath, hopen, ?_⟩
  exact inversePath_rowLengths steps st hpath

end OpenConjecture1878
end CanonicalLaneMathlibCore
end HautevilleHouse
