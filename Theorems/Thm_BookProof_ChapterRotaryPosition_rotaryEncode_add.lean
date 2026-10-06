-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.rotaryEncode_add
import Definitions.Def_ChapterCoherentOverlapComplex
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex


theorem BookProof.ChapterRotaryPosition.rotaryEncode_add (omega : Fin n → ℝ) (p p' : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    rotaryEncode omega (p + p') q = rotaryEncode omega p (rotaryEncode omega p' q) := by sorry
