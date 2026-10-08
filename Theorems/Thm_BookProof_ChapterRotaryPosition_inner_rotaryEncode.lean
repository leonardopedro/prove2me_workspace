-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.inner_rotaryEncode
import Definitions.Def_ChapterCoherentOverlapComplex
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


theorem BookProof.ChapterRotaryPosition.inner_rotaryEncode (omega : Fin n → ℝ) (a b : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (rotaryEncode omega a q) (rotaryEncode omega b k) : ℂ)
      = inner ℂ q (rotaryEncode omega (b - a) k) := by sorry
