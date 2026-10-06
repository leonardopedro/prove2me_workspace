-- Generated from ChapterConservativeDiagonal.lean — solution of BookProof.ConservativeDiagonal.commutes_all_events_iff_isDiag
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
import Theorems.Thm_BookProof_ConservativeDiagonal_bracket_eventProj_apply
open BookProof.ConservativeDiagonal



open scoped Matrix
open Matrix BookProof.FreeFieldConstraint


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) :
    (∀ S : Finset n, bracket H (eventProj S) = 0) ↔ H.IsDiag := by

  constructor
  · intro h k l hkl
    have := congrFun (congrFun (h {l}) k) l
    rw [bracket_eventProj_apply] at this
    simp only [Matrix.zero_apply, Finset.mem_singleton] at this
    have hkl' : ¬ (k = l) := hkl
    simp only [hkl', if_true, if_false] at this
    simpa using this
  · intro hdiag S
    ext k l
    rw [bracket_eventProj_apply]
    by_cases hkl : k = l
    · subst hkl; simp
    · rw [hdiag hkl]; simp
