-- Generated from ChapterConservativeDiagonal.lean — theorem BookProof.ConservativeDiagonal.eventProj_idem
import Definitions.Def_ChapterFreeFieldConstraint
import Mathlib
import Definitions.Def_ChapterConservativeDiagonal
open BookProof.ConservativeDiagonal


open scoped Matrix
open Matrix BookProof.FreeFieldConstraint


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ConservativeDiagonal.eventProj_idem (S : Finset n) : eventProj S * eventProj S = eventProj S := by sorry
