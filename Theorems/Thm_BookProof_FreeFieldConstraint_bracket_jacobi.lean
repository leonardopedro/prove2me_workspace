-- Generated from ChapterFreeFieldConstraint.lean — theorem BookProof.FreeFieldConstraint.bracket_jacobi
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint



variable {R : Type*} [Ring R]


theorem BookProof.FreeFieldConstraint.bracket_jacobi (a b c : R) :
    bracket (bracket a b) c + bracket (bracket b c) a + bracket (bracket c a) b = 0 := by sorry
