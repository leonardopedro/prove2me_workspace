-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.effectiveSupport_scoreSoftmax_zero
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Theorems.Thm_BookProof_ChapterAttentionCollision_effectiveSupport_uniform
import Theorems.Thm_BookProof_ChapterSoftmaxSharpness_scoreSoftmax_zero
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) :
    effectiveSupport (scoreSoftmax 0 s) = (m : ℝ) := by

  have hm : 0 < m := Fin.pos i
  have : scoreSoftmax (0 : ℝ) s = fun _ : Fin m => (1 : ℝ) / m := by
    funext j; exact scoreSoftmax_zero s j
  rw [this, effectiveSupport_uniform hm]
