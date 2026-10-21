-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.inner_rotaryEncode_shift
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Theorems.Thm_BookProof_ChapterRotaryPosition_inner_rotaryEncode
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (a b c : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (rotaryEncode omega (a + c) q) (rotaryEncode omega (b + c) k) : ℂ)
      = inner ℂ (rotaryEncode omega a q) (rotaryEncode omega b k) := by

  rw [inner_rotaryEncode, inner_rotaryEncode]
  congr 2
  ring
