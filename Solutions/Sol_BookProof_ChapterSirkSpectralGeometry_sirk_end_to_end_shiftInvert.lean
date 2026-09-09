-- Generated from ChapterSirkSpectralGeometry.lean — solution of BookProof.ChapterSirkSpectralGeometry.sirk_end_to_end_shiftInvert
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
import Theorems.Thm_BookProof_ChapterSirkSpectralGeometry_numRange_subset_realSegment_of_shiftInvert
import Theorems.Thm_BookProof_ChapterSirkSpectralGeometry_sirk_end_to_end_crouzeix_domain
open BookProof.ChapterSirkSpectralGeometry









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}







variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution
    {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ)
    (V : G →L[ℂ] F) (qX qXinv : F →L[ℂ] F) (qBinv : G →L[ℂ] G) (p : Polynomial ℂ)
    (flow psiX : F →L[ℂ] F) (psiB : G →L[ℂ] G) (C Dmin h : ℝ) (m : ℕ)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : F, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : G, ∃ y : G, R (V x) = V y)
    (hinvq : ∀ x : G, ∃ y : G, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ F)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ G)
    (hflow : flow = psiX)
    (hcxX : numRange R ⊆ realSegment 0 γ⁻¹ →
      ‖psiX - (Polynomial.aeval R p).comp qXinv‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcxB : numRange (compress V R) ⊆ realSegment 0 γ⁻¹ →
      ‖psiB - (Polynomial.aeval (compress V R) p).comp qBinv‖
        ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : F) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m :=
  sirk_end_to_end_crouzeix_domain V R qX qXinv qBinv p flow psiX psiB C Dmin h m
      (realSegment 0 γ⁻¹)
      (numRange_subset_realSegment_of_shiftInvert hR hsym hpos hγ)
      hVV hViso hVadj hinvX hinvq hqXl hqBr hflow hcxX hcxB v hv
