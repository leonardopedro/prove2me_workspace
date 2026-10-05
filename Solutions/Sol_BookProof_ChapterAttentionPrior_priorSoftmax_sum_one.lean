-- Generated from ChapterAttentionPrior.lean — solution of BookProof.ChapterAttentionPrior.priorSoftmax_sum_one
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Theorems.Thm_BookProof_ChapterAttentionPrior_priorDenom_pos
open BookProof.ChapterAttentionPrior



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ)
    (s : Fin m → ℝ) (i : Fin m) : ∑ j, priorSoftmax w beta s j = 1 := by

  simp only [priorSoftmax]
  rw [← Finset.sum_div]
  exact div_self (priorDenom_pos hw beta s i).ne'
