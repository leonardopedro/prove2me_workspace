-- Generated from ChapterAttentionFactorization.lean — theorem BookProof.ChapterAttentionFactorization.prodSoftmax_apply
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


theorem BookProof.ChapterAttentionFactorization.prodSoftmax_apply (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (a : Fin m₁) (b : Fin m₂) :
    prodSoftmax beta s₁ s₂ (a, b) = scoreSoftmax beta s₁ a * scoreSoftmax beta s₂ b := by sorry
