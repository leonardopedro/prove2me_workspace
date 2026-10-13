-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.constraint_commutation_identity
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
-- bracket_zero_right is declared in the def bundle LOCALLY but the platform's
-- published copy predates it (mirror text has 0 hits); the published sibling
-- thm stub is the platform-visible source of the name.
import Theorems.Thm_BookProof_FreeFieldConstraint_bracket_zero_right

open BookProof.FreeFieldConstraint

variable {R : Type*} [Ring R]

variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D H A : R) (hDH : bracket D H = 0) :
    bracket (bracket D A) H = - bracket D (bracket H A) := by

  have key : bracket (bracket D A) H + bracket D (bracket H A)
      = - bracket A (bracket D H) := by
    simp only [bracket]; noncomm_ring
  rw [hDH] at key
  simp only [bracket_zero_right, neg_zero] at key
  exact eq_neg_of_add_eq_zero_left key
