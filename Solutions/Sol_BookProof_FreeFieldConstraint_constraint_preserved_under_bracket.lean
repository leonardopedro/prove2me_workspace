-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.constraint_preserved_under_bracket
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
import Theorems.Thm_BookProof_FreeFieldConstraint_bracket_zero_left
import Theorems.Thm_BookProof_FreeFieldConstraint_constraint_commutation_identity
open BookProof.FreeFieldConstraint




variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D H A : R)
    (hDH : bracket D H = 0) (hDA : bracket D A = 0) :
    bracket D (bracket H A) = 0 := by

  have h := constraint_commutation_identity D H A hDH
  rw [hDA, bracket_zero_left] at h
  rw [eq_comm, neg_eq_zero] at h
  exact h
