-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.coherentOverlapC_rotaryEncode
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterRotaryPosition


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}


theorem BookProof.ChapterRotaryPosition.coherentOverlapC_rotaryEncode (omega : Fin n → ℝ) (a b : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (rotaryEncode omega a q) (rotaryEncode omega b k)
      = coherentOverlapC q (rotaryEncode omega (b - a) k) := by sorry
