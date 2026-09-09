-- Generated from ChapterSirkWhitening.lean — theorem BookProof.ChapterSirkWhitening.compress_conj_whitening
import Mathlib
import Definitions.Def_ChapterSirkWhitening
open BookProof.ChapterSirkWhitening







noncomputable section


open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterSirkWhitening.compress_conj_whitening (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E) (X : E →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) :
    compress V₁ X
      = (whiteningEquiv V₂ V₁).comp ((compress V₂ X).comp (whiteningEquiv V₁ V₂)) := by sorry
