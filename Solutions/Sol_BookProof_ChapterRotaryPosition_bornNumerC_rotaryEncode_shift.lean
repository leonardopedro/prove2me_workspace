-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.bornNumerC_rotaryEncode_shift
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Theorems.Thm_BookProof_ChapterRotaryPosition_coherentOverlapC_rotaryEncode
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (a b c : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC (rotaryEncode omega (a + c) q) (rotaryEncode omega (b + c) k)
      = bornNumerC (rotaryEncode omega a q) (rotaryEncode omega b k) := by

  rw [bornNumerC, bornNumerC, coherentOverlapC_rotaryEncode, coherentOverlapC_rotaryEncode,
    show b + c - (a + c) = b - a from by ring]
