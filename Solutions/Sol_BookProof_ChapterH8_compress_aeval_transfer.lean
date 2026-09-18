-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_aeval_transfer
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_compress_aeval_comp
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (p : Polynomial ℂ)
    (v : E) (hv : V ((adjoint V) v) = v) :
    (Polynomial.aeval X p) v = V ((Polynomial.aeval (compress V X) p) ((adjoint V) v)) := by

  have h := congrArg (fun f : F →L[ℂ] E => f ((adjoint V) v))
    (compress_aeval_comp V X hVV hinv p)
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at h
  rw [hv] at h
  exact h
