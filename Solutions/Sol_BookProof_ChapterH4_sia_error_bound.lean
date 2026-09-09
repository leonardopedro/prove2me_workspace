-- Generated from ChapterH4.lean — solution of BookProof.ChapterH4.sia_error_bound
import Mathlib
import Definitions.Def_ChapterH4
open BookProof.ChapterH4










open scoped BigOperators


noncomputable section





variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution
    (V : F →L[ℂ] E) (phiA psiX pX : E →L[ℂ] E) (psiB pB : F →L[ℂ] F)
    (C Dsia : ℝ)
    (hphi : phiA = psiX)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hrt : ∀ v : E, pX v = V (pB (V.adjoint v)))
    (hcx1 : ‖psiX - pX‖ ≤ C * Dsia)
    (hcx2 : ‖psiB - pB‖ ≤ C * Dsia)
    (v : E) :
    ‖phiA v - V (psiB (V.adjoint v))‖ ≤ 2 * C * Dsia * ‖v‖ := by

  have h_triangle :
      ‖phiA v - V (psiB (V.adjoint v))‖
        ≤ ‖(psiX - pX) v‖ + ‖V ((pB - psiB) (V.adjoint v))‖ := by
    convert norm_add_le ((psiX - pX) v) (V ((pB - psiB) (V.adjoint v))) using 2
    simp [hphi, hrt]
  have h_bounds :
      ‖(psiX - pX) v‖ ≤ C * Dsia * ‖v‖ ∧
        ‖V ((pB - psiB) (V.adjoint v))‖ ≤ C * Dsia * ‖v‖ := by
    refine ⟨?_, ?_⟩
    · exact le_trans (ContinuousLinearMap.le_opNorm _ _)
        (mul_le_mul_of_nonneg_right hcx1 (norm_nonneg _))
    · rw [hViso]
      refine le_trans (ContinuousLinearMap.le_opNorm _ _) ?_
      exact mul_le_mul (by simpa only [norm_sub_rev] using hcx2) (hVadj v) (norm_nonneg _)
        (by nlinarith [norm_nonneg (psiX - pX), norm_nonneg (psiB - pB)])
  linarith
