-- Generated from ChapterFreeFieldConstraint.lean — theorem BookProof.FreeFieldConstraint.constraint_preserved_under_bracket
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint



variable {R : Type*} [Ring R]


theorem BookProof.FreeFieldConstraint.constraint_preserved_under_bracket (D H A : R)
    (hDH : bracket D H = 0) (hDA : bracket D A = 0) :
    bracket D (bracket H A) = 0 := by sorry
