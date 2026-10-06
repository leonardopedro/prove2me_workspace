-- Generated from ChapterConservativeDiagonal.lean — theorem BookProof.ConservativeDiagonal.conservative_iff_isDiag
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint
open BookProof.ConservativeDiagonal

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix
open Matrix BookProof.FreeFieldConstraint



theorem BookProof.ConservativeDiagonal.conservative_iff_isDiag (H : Matrix n n ℂ) :
    (∀ S T : Finset n, bracket (bracket H (eventProj S)) (eventProj T) = 0) ↔ H.IsDiag := by sorry
