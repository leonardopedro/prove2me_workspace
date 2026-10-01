-- Generated from ChapterFreeFieldConstraint.lean — theorem BookProof.FreeFieldConstraint.constraint_commutation_identity_field
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint

variable {R : Type*} [Ring R]




theorem BookProof.FreeFieldConstraint.constraint_commutation_identity_field (D H φ0 : R) (hDH : bracket D H = 0) :
    bracket (bracket D φ0) H = - bracket D (bracket H φ0) := by sorry
