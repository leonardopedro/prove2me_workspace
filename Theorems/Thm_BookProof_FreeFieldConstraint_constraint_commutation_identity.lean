-- Generated from ChapterFreeFieldConstraint.lean — theorem BookProof.FreeFieldConstraint.constraint_commutation_identity
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint

variable {R : Type*} [Ring R]



variable {R : Type*} [Ring R]

theorem BookProof.FreeFieldConstraint.constraint_commutation_identity (D H A : R) (hDH : bracket D H = 0) :
    bracket (bracket D A) H = - bracket D (bracket H A) := by sorry
