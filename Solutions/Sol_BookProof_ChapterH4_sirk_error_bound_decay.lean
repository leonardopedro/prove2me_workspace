-- Generated from ChapterH4.lean — solution of BookProof.ChapterH4.sirk_error_bound_decay
import Mathlib
import Definitions.Def_ChapterH4
import Theorems.Thm_BookProof_ChapterH4_sirk_error_bound
open BookProof.ChapterH4










open scoped BigOperators


noncomputable section





variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution
    (V : F →L[ℂ] E) (phiA psiX rX : E →L[ℂ] E) (psiB rB : F →L[ℂ] F)
    (C D Dmin h m : ℝ)
    (hphi : phiA = psiX)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hrt : ∀ v : E, rX v = V (rB (V.adjoint v)))
    (hcx1 : ‖psiX - rX‖ ≤ C * D)
    (hcx2 : ‖psiB - rB‖ ≤ C * D)
    (hC : 0 ≤ C) (hdecay : D ≤ Real.exp (-(h * m)) * Dmin)
    (v : E) :
    ‖phiA v - V (psiB (V.adjoint v))‖ ≤ 2 * C * Real.exp (-(h * m)) * Dmin * ‖v‖ := by

  refine le_trans (sirk_error_bound V phiA psiX rX psiB rB C D
    hphi hViso hVadj hrt hcx1 hcx2 v) ?_
  convert mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_left hdecay (mul_nonneg zero_le_two hC)) (norm_nonneg v) using 1
  ring
