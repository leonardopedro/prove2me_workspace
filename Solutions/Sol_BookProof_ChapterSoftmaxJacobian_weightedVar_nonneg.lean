-- Generated from ChapterSoftmaxJacobian.lean — solution of BookProof.ChapterSoftmaxJacobian.weightedVar_nonneg
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Theorems.Thm_BookProof_ChapterSoftmaxJacobian_weightedVar_eq_sum_sq
open BookProof.ChapterSoftmaxJacobian



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s x : Fin m → ℝ) (i : Fin m) :
    0 ≤ weightedVar beta s x := by

  rw [weightedVar_eq_sum_sq beta s x i]
  exact Finset.sum_nonneg fun j _ =>
    mul_nonneg (le_of_lt (scoreSoftmax_pos beta s j)) (sq_nonneg _)
