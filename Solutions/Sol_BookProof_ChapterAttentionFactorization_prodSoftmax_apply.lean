-- Generated from ChapterAttentionFactorization.lean — solution of BookProof.ChapterAttentionFactorization.prodSoftmax_apply
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Theorems.Thm_BookProof_ChapterAttentionFactorization_prodSoftmax_eq_mul
open BookProof.ChapterAttentionFactorization



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m₁ m₂ : ℕ}

variable {m₁ m₂ : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (a : Fin m₁) (b : Fin m₂) :
    prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a * scoreSoftmax beta s₂ b := prodSoftmax_eq_mul beta s₁ s₂ (a, b)
