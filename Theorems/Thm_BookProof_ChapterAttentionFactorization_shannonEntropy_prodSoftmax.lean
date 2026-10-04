-- Generated from ChapterAttentionFactorization.lean — theorem BookProof.ChapterAttentionFactorization.shannonEntropy_prodSoftmax
import Mathlib
import Definitions.Def_ChapterAttentionFactorization
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionFactorization

variable {m₁ m₂ : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionFactorization.shannonEntropy_prodSoftmax (beta : ℝ) (s₁ : Fin m₁ → ℝ) (s₂ : Fin m₂ → ℝ)
    (i₁ : Fin m₁) (i₂ : Fin m₂) :
    shannonEntropyProd (prodSoftmax beta s₁ s₂)
      = shannonEntropy (scoreSoftmax beta s₁) + shannonEntropy (scoreSoftmax beta s₂) := by sorry
