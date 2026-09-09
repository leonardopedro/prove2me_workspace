-- Generated from ChapterSirkWhitening.lean — solution of BookProof.ChapterSirkWhitening.rangeProj_comp_of_le
import Mathlib
import Definitions.Def_ChapterSirkWhitening
import Theorems.Thm_BookProof_ChapterSirkWhitening_rangeProj_comp_embedding
open BookProof.ChapterSirkWhitening








noncomputable section


open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (hle : ∀ y : F, ∃ z : G, V₁ y = V₂ z) :
    (rangeProj V₂).comp (rangeProj V₁) = rangeProj V₁ := by

  ext u
  obtain ⟨z, hz⟩ := hle (V₁.adjoint u)
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, rangeProj_apply]
  rw [hz]
  exact rangeProj_comp_embedding V₂ hV₂ z
