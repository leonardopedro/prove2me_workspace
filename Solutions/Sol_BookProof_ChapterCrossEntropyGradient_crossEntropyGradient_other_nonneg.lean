-- Generated from ChapterCrossEntropyGradient.lean — solution of BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_other_nonneg
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_nonneg
open BookProof.ChapterCrossEntropyGradient



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    {y i : Fin m} (h : i ≠ y) : 0 ≤ crossEntropyGradient beta s y i := by

  have hp : 0 ≤ scoreSoftmax beta s i := scoreSoftmax_nonneg beta s i
  simpa [crossEntropyGradient, h] using mul_nonneg hb hp
