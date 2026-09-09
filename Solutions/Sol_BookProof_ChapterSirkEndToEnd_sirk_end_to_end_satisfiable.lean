-- Generated from ChapterSirkEndToEnd.lean — solution of BookProof.ChapterSirkEndToEnd.sirk_end_to_end_satisfiable
import Mathlib
import Definitions.Def_ChapterSirkEndToEnd
import Theorems.Thm_BookProof_ChapterSirkEndToEnd_sirk_end_to_end
open BookProof.ChapterSirkEndToEnd











noncomputable section

open Filter Topology


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH8 BookProof.ChapterH9

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution
    (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : F, ∃ y : F, X (V x) = V y)
    (m : ℕ) (v : E) (hv : V (V.adjoint v) = v) :
    ‖X v - sirkApprox V (compress V X) v‖ ≤ sirkBound 1 1 1 ‖v‖ m := by

  refine sirk_end_to_end V X (ContinuousLinearMap.id ℂ E) (ContinuousLinearMap.id ℂ E)
    (ContinuousLinearMap.id ℂ F) (Polynomial.X : Polynomial ℂ) X X (compress V X) 1 1 1 m
    hVV hViso hVadj hinvX (fun x => ⟨x, rfl⟩) (by ext x; simp) ?_ rfl ?_ ?_ v hv
  · have hcid : compress V (ContinuousLinearMap.id ℂ E) = ContinuousLinearMap.id ℂ F := by
      ext x; simpa using congrArg (fun f : F →L[ℂ] F => f x) hVV
    rw [hcid]; ext x; simp
  · have : (Polynomial.aeval X (Polynomial.X : Polynomial ℂ) : E →L[ℂ] E).comp
        (ContinuousLinearMap.id ℂ E) = X := by ext x; simp
    rw [this, sub_self, norm_zero]
    positivity
  · have : (Polynomial.aeval (compress V X) (Polynomial.X : Polynomial ℂ) : F →L[ℂ] F).comp
        (ContinuousLinearMap.id ℂ F) = compress V X := by ext x; simp
    rw [this, sub_self, norm_zero]
    positivity
