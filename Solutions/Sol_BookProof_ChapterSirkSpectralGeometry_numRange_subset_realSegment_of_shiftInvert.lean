-- Generated from ChapterSirkSpectralGeometry.lean — solution of BookProof.ChapterSirkSpectralGeometry.numRange_subset_realSegment_of_shiftInvert
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
open BookProof.ChapterSirkSpectralGeometry









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) :
    numRange R ⊆ realSegment 0 γ⁻¹ := by

  rintro c ⟨x, hx, rfl⟩
  have hsa : IsSelfAdjoint R := hR.isSelfAdjoint hsym
  have hsymm : ∀ u v : F, (inner ℂ (R u) v : ℂ) = inner ℂ u (R v) :=
    ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hsa
  refine ⟨?_, ?_, ?_⟩
  · have h1 : (starRingEnd ℂ) (inner ℂ x (R x) : ℂ) = (inner ℂ x (R x) : ℂ) := by
      rw [inner_conj_symm, hsymm x x]
    have := Complex.conj_eq_iff_im.mp h1
    simpa using this
  · simpa using hR.inner_nonneg hpos hγ x
  · have hR' : ‖R x‖ ≤ γ⁻¹ * ‖x‖ := hR.norm_apply_le hpos hγ x
    calc (inner ℂ x (R x) : ℂ).re
        ≤ ‖(inner ℂ x (R x) : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖x‖ * ‖R x‖ := norm_inner_le_norm _ _
      _ ≤ γ⁻¹ := by rw [hx, one_mul]; simpa [hx] using hR'
