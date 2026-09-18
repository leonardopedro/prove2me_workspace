-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.compress_aeval_transfer
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.compress_aeval_transfer (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (p : Polynomial ℂ)
    (v : E) (hv : V ((adjoint V) v) = v) :
    (Polynomial.aeval X p) v = V ((Polynomial.aeval (compress V X) p) ((adjoint V) v)) := by sorry
