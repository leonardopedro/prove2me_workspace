-- Generated from ChapterAttentionFactorization.lean — solution of BookProof.ChapterAttentionFactorization.prodSoftmax_pos
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Theorems.Thm_BookProof_ChapterAttentionFactorization_prodSoftmax_eq_mul
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_pos
open BookProof.ChapterAttentionFactorization



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m₁ m₂ : ℕ}

variable {m₁ m₂ : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (j : Fin m₁ × Fin m₂) : 0 < prodSoftmax beta s₁ s₂ j := by

  rw [prodSoftmax_eq_mul]
  exact mul_pos (scoreSoftmax_pos beta s₁ j.1) (scoreSoftmax_pos beta s₂ j.2)
