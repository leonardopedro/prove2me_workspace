-- Generated from ChapterAttentionFactorization.lean — theorem BookProof.ChapterAttentionFactorization.prodSoftmax_marginal_left
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


theorem BookProof.ChapterAttentionFactorization.prodSoftmax_marginal_left (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₂ : Fin m₂) (a : Fin m₁) :
    ∑ b, prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a := by sorry
