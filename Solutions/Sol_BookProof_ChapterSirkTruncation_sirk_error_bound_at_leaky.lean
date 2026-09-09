-- Generated from ChapterSirkTruncation.lean — solution of BookProof.ChapterSirkTruncation.sirk_error_bound_at_leaky
import Mathlib
import Definitions.Def_ChapterSirkTruncation
open BookProof.ChapterSirkTruncation









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterSirkEndToEnd
open BookProof.ChapterSirkWhitening

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution
    (V : F →L[ℂ] E) (phiA psiX rX : E →L[ℂ] E) (psiB rB : F →L[ℂ] F)
    (C D rho : ℝ)
    (hphi : phiA = psiX)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hcx1 : ‖psiX - rX‖ ≤ C * D)
    (hcx2 : ‖psiB - rB‖ ≤ C * D)
    (v : E) (hrt : ‖rX v - V (rB (V.adjoint v))‖ ≤ rho) :
    ‖phiA v - sirkApprox V psiB v‖ ≤ 2 * C * D * ‖v‖ + rho := by

  have hCD : 0 ≤ C * D := le_trans (norm_nonneg _) hcx2
  have key : phiA v - sirkApprox V psiB v
      = (psiX - rX) v + (rX v - V (rB (V.adjoint v)))
        + V ((rB - psiB) (V.adjoint v)) := by
    have h1 : V ((rB - psiB) (V.adjoint v))
        = V (rB (V.adjoint v)) - V (psiB (V.adjoint v)) := by
      rw [ContinuousLinearMap.sub_apply, map_sub]
    rw [h1, ContinuousLinearMap.sub_apply, hphi, sirkApprox_apply]
    abel
  rw [key]
  have h1 : ‖(psiX - rX) v‖ ≤ C * D * ‖v‖ :=
    le_trans (ContinuousLinearMap.le_opNorm _ _)
      (mul_le_mul_of_nonneg_right hcx1 (norm_nonneg _))
  have h2 : ‖V ((rB - psiB) (V.adjoint v))‖ ≤ C * D * ‖v‖ := by
    rw [hViso]
    refine le_trans (ContinuousLinearMap.le_opNorm _ _) ?_
    exact mul_le_mul (by simpa only [norm_sub_rev] using hcx2) (hVadj v) (norm_nonneg _) hCD
  calc ‖(psiX - rX) v + (rX v - V (rB (V.adjoint v))) + V ((rB - psiB) (V.adjoint v))‖
      ≤ ‖(psiX - rX) v + (rX v - V (rB (V.adjoint v)))‖
        + ‖V ((rB - psiB) (V.adjoint v))‖ := norm_add_le _ _
    _ ≤ (‖(psiX - rX) v‖ + ‖rX v - V (rB (V.adjoint v))‖)
        + ‖V ((rB - psiB) (V.adjoint v))‖ := by
        gcongr; exact norm_add_le _ _
    _ ≤ (C * D * ‖v‖ + rho) + C * D * ‖v‖ := by gcongr
    _ = 2 * C * D * ‖v‖ + rho := by ring
