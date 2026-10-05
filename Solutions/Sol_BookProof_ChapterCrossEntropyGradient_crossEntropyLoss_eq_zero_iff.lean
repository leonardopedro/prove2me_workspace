-- Generated from ChapterCrossEntropyGradient.lean — solution of BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Theorems.Thm_BookProof_ChapterCrossEntropyGradient_crossEntropyLoss_eq_neg_log
open BookProof.ChapterCrossEntropyGradient



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    crossEntropyLoss beta s y = 0 ↔ scoreSoftmax beta s y = 1 := by

  rw [crossEntropyLoss_eq_neg_log, neg_eq_zero]
  constructor
  · intro h
    have hpos : 0 < scoreSoftmax beta s y := scoreSoftmax_pos beta s y
    rcases Real.log_eq_zero.1 h with h0 | h1 | hm1
    · exact absurd h0 (ne_of_gt hpos)
    · exact h1
    · linarith
  · intro h
    rw [h, Real.log_one]
