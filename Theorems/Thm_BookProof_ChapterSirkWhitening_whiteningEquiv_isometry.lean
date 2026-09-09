-- Generated from ChapterSirkWhitening.lean — theorem BookProof.ChapterSirkWhitening.whiteningEquiv_isometry
import Mathlib
import Definitions.Def_ChapterSirkWhitening
open BookProof.ChapterSirkWhitening







noncomputable section


open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.ChapterSirkWhitening.whiteningEquiv_isometry (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₁ : ∀ y : F, ‖V₁ y‖ = ‖y‖) (hV₂ : ∀ z : G, ‖V₂ z‖ = ‖z‖)
    (hV₂adj : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) (y : F) :
    ‖whiteningEquiv V₁ V₂ y‖ = ‖y‖ := by sorry
