-- Generated from ChapterSirkWhitening.lean — theorem BookProof.ChapterSirkWhitening.rangeProj_eq_of_range_eq
import Mathlib
import Definitions.Def_ChapterSirkWhitening
open BookProof.ChapterSirkWhitening







noncomputable section


open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterSirkWhitening.rangeProj_eq_of_range_eq (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₁ : V₁.adjoint.comp V₁ = ContinuousLinearMap.id ℂ F)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z)
    (h21 : ∀ z : G, ∃ y : F, V₂ z = V₁ y) :
    rangeProj V₁ = rangeProj V₂ := by sorry
