-- Generated from ChapterAttentionFactorization.lean — solution of BookProof.ChapterAttentionFactorization.prodSoftmax_sum_one
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Theorems.Thm_BookProof_ChapterAttentionFactorization_prodSoftmax_apply
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionFactorization



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m₁ m₂ : ℕ}

variable {m₁ m₂ : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (i₂ : Fin m₂) : ∑ j : Fin m₁ × Fin m₂, prodSoftmax beta s₁ s₂ j = 1 := by

  have h₁ : ∑ a, scoreSoftmax beta s₁ a = 1 := scoreSoftmax_sum_one beta s₁ i₁
  have h₂ : ∑ b, scoreSoftmax beta s₂ b = 1 := scoreSoftmax_sum_one beta s₂ i₂
  rw [Fintype.sum_prod_type]
  rw [Finset.sum_congr rfl fun a _ => (by
    rw [Finset.sum_congr rfl fun b _ => prodSoftmax_apply beta s₁ s₂ a b, ← Finset.mul_sum,
      h₂, mul_one] :
      ∑ b, prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a), h₁]
