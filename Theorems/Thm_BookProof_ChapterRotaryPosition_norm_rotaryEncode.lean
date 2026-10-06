-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.norm_rotaryEncode
import Definitions.Def_ChapterCoherentOverlapComplex
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex


theorem BookProof.ChapterRotaryPosition.norm_rotaryEncode (omega : Fin n → ℝ) (p : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    ‖rotaryEncode omega p q‖ = ‖q‖ := by sorry
