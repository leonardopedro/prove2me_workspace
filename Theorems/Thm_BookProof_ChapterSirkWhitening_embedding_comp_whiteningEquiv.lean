-- Generated from ChapterSirkWhitening.lean — theorem BookProof.ChapterSirkWhitening.embedding_comp_whiteningEquiv
import Definitions.Def_ChapterH4
import Mathlib
import Definitions.Def_ChapterSirkWhitening
open BookProof.ChapterSirkWhitening

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


noncomputable section


open BookProof.ChapterH4


theorem BookProof.ChapterSirkWhitening.embedding_comp_whiteningEquiv (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) (y : F) :
    V₂ (whiteningEquiv V₁ V₂ y) = V₁ y := by sorry
