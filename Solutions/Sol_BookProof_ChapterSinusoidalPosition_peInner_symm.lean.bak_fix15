-- Generated from ChapterSinusoidalPosition.lean — solution of BookProof.ChapterSinusoidalPosition.peInner_symm
import Mathlib
import Definitions.Def_ChapterSinusoidalPosition
import Theorems.Thm_BookProof_ChapterSinusoidalPosition_peInner_eq_sum_cos
open BookProof.ChapterSinusoidalPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin n → ℝ) (p q : ℝ) : peInner w p q = peInner w q p := by

  rw [peInner_eq_sum_cos, peInner_eq_sum_cos]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [show w a * (q - p) = -(w a * (p - q)) by ring, Real.cos_neg]
