-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.inner_rotaryEncode_shift
import Definitions.Def_ChapterCoherentOverlapComplex
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex


theorem BookProof.ChapterRotaryPosition.inner_rotaryEncode_shift (omega : Fin n → ℝ) (a b c : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (rotaryEncode omega (a + c) q) (rotaryEncode omega (b + c) k) : ℂ)
      = inner ℂ (rotaryEncode omega a q) (rotaryEncode omega b k) := by sorry
