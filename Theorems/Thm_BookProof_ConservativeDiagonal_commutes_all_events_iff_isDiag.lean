-- Generated from ChapterConservativeDiagonal.lean — theorem BookProof.ConservativeDiagonal.commutes_all_events_iff_isDiag
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint
open BookProof.ConservativeDiagonal

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix
open Matrix BookProof.FreeFieldConstraint



theorem BookProof.ConservativeDiagonal.commutes_all_events_iff_isDiag (H : Matrix n n ℂ) :
    (∀ S : Finset n, bracket H (eventProj S) = 0) ↔ H.IsDiag := by sorry
