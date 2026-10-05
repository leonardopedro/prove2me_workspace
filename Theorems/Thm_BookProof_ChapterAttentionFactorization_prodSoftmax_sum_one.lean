-- Generated from ChapterAttentionFactorization.lean — theorem BookProof.ChapterAttentionFactorization.prodSoftmax_sum_one
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionFactorization

variable {m₁ m₂ : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionFactorization.prodSoftmax_sum_one (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (i₂ : Fin m₂) : ∑ j : Fin m₁ × Fin m₂, prodSoftmax beta s₁ s₂ j = 1 := by sorry
