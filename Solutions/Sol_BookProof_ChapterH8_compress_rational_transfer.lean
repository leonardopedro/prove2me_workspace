-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_rational_transfer
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_compress_aeval_transfer
import Theorems.Thm_BookProof_ChapterH8_compress_inv_transfer_apply
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X qX qXinv : E →L[ℂ] E)
    (qBinv : F →L[ℂ] F) (p : Polynomial ℂ)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinvX : ∀ x : F, ∃ y : F, X (V x) = V y)
    (hinvq : ∀ x : F, ∃ y : F, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ F)
    (v : E) (hv : V ((adjoint V) v) = v) :
    (Polynomial.aeval X p) (qXinv v)
      = V ((Polynomial.aeval (compress V X) p) (qBinv ((adjoint V) v))) := by

  have hw : qXinv v = V (qBinv ((adjoint V) v)) :=
    compress_inv_transfer_apply V qX qXinv qBinv hVV hinvq hqXl hqBr v hv
  have hid : ∀ u : F, (adjoint V) (V u) = u :=
    fun u => congrArg (fun f : F →L[ℂ] F => f u) hVV
  have hVu : V ((adjoint V) (V (qBinv ((adjoint V) v)))) = V (qBinv ((adjoint V) v)) := by
    rw [hid]
  rw [hw, compress_aeval_transfer V X hVV hinvX p _ hVu, hid]
