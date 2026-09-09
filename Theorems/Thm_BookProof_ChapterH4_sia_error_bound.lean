-- Generated from ChapterH4.lean — theorem BookProof.ChapterH4.sia_error_bound
import Mathlib
import Definitions.Def_ChapterH4
open BookProof.ChapterH4









open scoped BigOperators


noncomputable section





variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterH4.sia_error_bound
    (V : F →L[ℂ] E) (phiA psiX pX : E →L[ℂ] E) (psiB pB : F →L[ℂ] F)
    (C Dsia : ℝ)
    (hphi : phiA = psiX)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hrt : ∀ v : E, pX v = V (pB (V.adjoint v)))
    (hcx1 : ‖psiX - pX‖ ≤ C * Dsia)
    (hcx2 : ‖psiB - pB‖ ≤ C * Dsia)
    (v : E) :
    ‖phiA v - V (psiB (V.adjoint v))‖ ≤ 2 * C * Dsia * ‖v‖ := by sorry
