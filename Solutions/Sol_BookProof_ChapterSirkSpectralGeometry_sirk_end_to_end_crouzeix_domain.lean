-- Generated from ChapterSirkSpectralGeometry.lean — solution of BookProof.ChapterSirkSpectralGeometry.sirk_end_to_end_crouzeix_domain
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
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
    (V : G →L[ℂ] E) (X qX qXinv : E →L[ℂ] E) (qBinv : G →L[ℂ] G) (p : Polynomial ℂ)
    (flow psiX : E →L[ℂ] E) (psiB : G →L[ℂ] G)
    (C Dmin h : ℝ) (m : ℕ) (S : Set ℂ)
    (hS : numRange X ⊆ S)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : G, ∃ y : G, X (V x) = V y)
    (hinvq : ∀ x : G, ∃ y : G, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ G)
    (hflow : flow = psiX)
    (hcxX : numRange X ⊆ S →
      ‖psiX - (Polynomial.aeval X p).comp qXinv‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcxB : numRange (compress V X) ⊆ S →
      ‖psiB - (Polynomial.aeval (compress V X) p).comp qBinv‖
        ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by

  have hSB : numRange (compress V X) ⊆ S :=
    ((numRange_compress_subset V X hViso).trans hS)
  exact sirk_end_to_end V X qX qXinv qBinv p flow psiX psiB C Dmin h m hVV hViso hVadj
    hinvX hinvq hqXl hqBr hflow (hcxX hS) (hcxB hSB) v hv
