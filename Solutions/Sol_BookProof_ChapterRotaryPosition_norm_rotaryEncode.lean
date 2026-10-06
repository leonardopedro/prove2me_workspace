-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.norm_rotaryEncode
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (p : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    ‖rotaryEncode omega p q‖ = ‖q‖ := by

  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [rotaryEncode_apply, norm_mul, Complex.norm_exp_ofReal_mul_I, one_mul]
