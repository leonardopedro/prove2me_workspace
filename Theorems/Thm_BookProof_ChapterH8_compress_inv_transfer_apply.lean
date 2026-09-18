-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.compress_inv_transfer_apply
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.compress_inv_transfer_apply (V : F →L[ℂ] E) (qX qXinv : E →L[ℂ] E) (qBinv : F →L[ℂ] F)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ F)
    (v : E) (hv : V ((adjoint V) v) = v) :
    qXinv v = V (qBinv ((adjoint V) v)) := by sorry
