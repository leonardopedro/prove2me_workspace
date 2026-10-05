-- Generated from ChapterAttentionPrior.lean — solution of BookProof.ChapterAttentionPrior.priorSoftmax_zero
import Mathlib
import Definitions.Def_ChapterAttentionPrior
open BookProof.ChapterAttentionPrior



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin m → ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w 0 s j = w j / ∑ l, w l := by

  simp [priorSoftmax]
