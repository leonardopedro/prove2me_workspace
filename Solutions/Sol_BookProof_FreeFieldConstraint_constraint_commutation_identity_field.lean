-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.constraint_commutation_identity_field
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
import Theorems.Thm_BookProof_FreeFieldConstraint_constraint_commutation_identity
open BookProof.FreeFieldConstraint




variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (D H φ0 : R) (hDH : bracket D H = 0) :
    bracket (bracket D φ0) H = - bracket D (bracket H φ0) := constraint_commutation_identity D H φ0 hDH
