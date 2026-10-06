-- Generated from ChapterConservativeDiagonal.lean — theorem BookProof.ConservativeDiagonal.bracket_eventProj_apply
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint
open BookProof.ConservativeDiagonal

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix
open Matrix BookProof.FreeFieldConstraint



theorem BookProof.ConservativeDiagonal.bracket_eventProj_apply (H : Matrix n n ℂ) (S : Finset n) (k l : n) :
    bracket H (eventProj S) k l
      = H k l * ((if l ∈ S then (1 : ℂ) else 0) - (if k ∈ S then (1 : ℂ) else 0)) := by sorry
