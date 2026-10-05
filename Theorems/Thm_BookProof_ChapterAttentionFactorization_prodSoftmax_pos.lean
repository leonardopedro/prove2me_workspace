-- Generated from ChapterAttentionFactorization.lean — theorem BookProof.ChapterAttentionFactorization.prodSoftmax_pos
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


theorem BookProof.ChapterAttentionFactorization.prodSoftmax_pos (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (j : Fin m₁ × Fin m₂) : 0 < prodSoftmax beta s₁ s₂ j := by sorry
