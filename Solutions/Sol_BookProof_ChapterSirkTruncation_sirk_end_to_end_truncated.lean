-- Generated from ChapterSirkTruncation.lean — solution of BookProof.ChapterSirkTruncation.sirk_end_to_end_truncated
import Mathlib
import Definitions.Def_ChapterSirkTruncation
import Theorems.Thm_BookProof_ChapterSirkTruncation_sirk_error_bound_at_leaky
import Theorems.Thm_BookProof_ChapterSirkTruncation_transfer_defect_le_of_leakage
import Definitions.Def_ChapterSirkWhitening
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH4
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
    (V : F →L[ℂ] E) (rX : E →L[ℂ] E) (rB : F →L[ℂ] F)
    (flow psiX : E →L[ℂ] E) (psiB : F →L[ℂ] F) (C Dmin h : ℝ) (m : ℕ)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hflow : flow = psiX)
    (hcx1 : ‖psiX - rX‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcx2 : ‖psiB - rB‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hexact : rX (V (V.adjoint v)) = V (rB (V.adjoint (V (V.adjoint v)))))
    (hproj : V.adjoint (V (V.adjoint v)) = V.adjoint v) :
    ‖flow v - sirkApprox V psiB v‖
      ≤ sirkBound C Dmin h ‖v‖ m
        + ‖rX‖ * ‖v - V (V.adjoint v)‖ := by

  have hdef := transfer_defect_le_of_leakage V rX rB v hexact hproj
  have := sirk_error_bound_at_leaky V flow psiX rX psiB rB C
    (Real.exp (-(h * m)) * Dmin) _ hflow hViso hVadj hcx1 hcx2 v hdef
  simpa [sirkBound, mul_assoc] using this
