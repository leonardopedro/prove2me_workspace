-- Generated from ChapterRotaryPosition.lean — theorem BookProof.ChapterRotaryPosition.bornNumerC_rotaryEncode_shift
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterRotaryPosition

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex


theorem BookProof.ChapterRotaryPosition.bornNumerC_rotaryEncode_shift (omega : Fin n → ℝ) (a b c : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC (rotaryEncode omega (a + c) q) (rotaryEncode omega (b + c) k)
      = bornNumerC (rotaryEncode omega a q) (rotaryEncode omega b k) := by sorry
