-- Generated from ChapterCrossEntropyGradient.lean — solution of BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_nonneg
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Theorems.Thm_BookProof_ChapterCrossEntropyGradient_crossEntropyLoss_eq_neg_log
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_le_one
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_nonneg
open BookProof.ChapterCrossEntropyGradient



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    0 ≤ crossEntropyLoss beta s y := by

  rw [crossEntropyLoss_eq_neg_log, neg_nonneg]
  exact Real.log_nonpos (scoreSoftmax_nonneg beta s y) (scoreSoftmax_le_one beta s y)
