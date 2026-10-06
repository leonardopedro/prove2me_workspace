-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.coherentOverlapC_rotaryEncode
import Mathlib
import Definitions.Def_ChapterRotaryPosition
import Theorems.Thm_BookProof_ChapterRotaryPosition_norm_rotaryEncode
import Theorems.Thm_BookProof_ChapterRotaryPosition_inner_rotaryEncode
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (a b : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (rotaryEncode omega a q) (rotaryEncode omega b k)
      = coherentOverlapC q (rotaryEncode omega (b - a) k) := by

  rw [coherentOverlapC, coherentOverlapC, norm_rotaryEncode, norm_rotaryEncode,
    norm_rotaryEncode, inner_rotaryEncode]
