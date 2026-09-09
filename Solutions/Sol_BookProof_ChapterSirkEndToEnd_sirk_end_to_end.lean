-- Generated from ChapterSirkEndToEnd.lean — solution of BookProof.ChapterSirkEndToEnd.sirk_end_to_end
import Mathlib
import Definitions.Def_ChapterSirkEndToEnd
import Theorems.Thm_BookProof_ChapterSirkEndToEnd_sirk_error_bound_at
open BookProof.ChapterSirkEndToEnd











noncomputable section

open Filter Topology


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH8 BookProof.ChapterH9

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution
    (V : F →L[ℂ] E) (X qX qXinv : E →L[ℂ] E) (qBinv : F →L[ℂ] F) (p : Polynomial ℂ)
    (flow psiX : E →L[ℂ] E) (psiB : F →L[ℂ] F)
    (C Dmin h : ℝ) (m : ℕ)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : F, ∃ y : F, X (V x) = V y)
    (hinvq : ∀ x : F, ∃ y : F, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ F)
    (hflow : flow = psiX)
    (hcx1 : ‖psiX - (Polynomial.aeval X p).comp qXinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcx2 : ‖psiB - (Polynomial.aeval (compress V X) p).comp qBinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by

  have hrt : ((Polynomial.aeval X p).comp qXinv) v
      = V (((Polynomial.aeval (compress V X) p).comp qBinv) (V.adjoint v)) := by
    simpa using
      compress_rational_transfer V X qX qXinv qBinv p hVV hinvX hinvq hqXl hqBr v hv
  have := sirk_error_bound_at V flow psiX ((Polynomial.aeval X p).comp qXinv)
    psiB ((Polynomial.aeval (compress V X) p).comp qBinv)
    C (Real.exp (-(h * m)) * Dmin) hflow hViso hVadj hcx1 hcx2 v hrt
  simpa [sirkBound, mul_assoc] using this
