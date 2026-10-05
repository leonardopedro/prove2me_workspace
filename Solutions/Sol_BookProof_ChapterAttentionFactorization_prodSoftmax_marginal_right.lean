-- Generated from ChapterAttentionFactorization.lean — solution of BookProof.ChapterAttentionFactorization.prodSoftmax_marginal_right
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Theorems.Thm_BookProof_ChapterAttentionFactorization_prodSoftmax_apply
open BookProof.ChapterAttentionFactorization



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m₁ m₂ : ℕ}

variable {m₁ m₂ : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (b : Fin m₂) :
    ∑ a, prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₂ b := by

  rw [Finset.sum_congr rfl fun a _ => prodSoftmax_apply beta s₁ s₂ a b, ← Finset.sum_mul,
    scoreSoftmax_sum_one beta s₁ i₁, one_mul]
