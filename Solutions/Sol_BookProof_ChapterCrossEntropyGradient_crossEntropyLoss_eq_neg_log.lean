-- Generated from ChapterCrossEntropyGradient.lean — solution of BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_eq_neg_log
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_partition_ne_zero
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_scoreSoftmax_eq_div
open BookProof.ChapterCrossEntropyGradient



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    crossEntropyLoss beta s y = -Real.log (scoreSoftmax beta s y) := by

  have hZ : partition beta s ≠ 0 := partition_ne_zero beta s y
  rw [crossEntropyLoss, scoreSoftmax_eq_div, Real.log_div (Real.exp_ne_zero _) hZ,
    Real.log_exp, logPartition]
  ring
