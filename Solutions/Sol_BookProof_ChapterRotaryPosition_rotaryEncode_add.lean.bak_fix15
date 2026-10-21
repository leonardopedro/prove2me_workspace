-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.rotaryEncode_add
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (p p' : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    rotaryEncode omega (p + p') q = rotaryEncode omega p (rotaryEncode omega p' q) := by

  ext i
  rw [rotaryEncode_apply, rotaryEncode_apply, rotaryEncode_apply, ← mul_assoc,
    ← Complex.exp_add]
  congr 2
  push_cast
  ring
