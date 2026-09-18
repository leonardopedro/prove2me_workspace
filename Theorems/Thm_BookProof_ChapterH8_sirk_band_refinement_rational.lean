-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_band_refinement_rational
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_band_refinement_rational (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X qX qXinv : E →L[ℂ] E) (qBninv : F →L[ℂ] F) (qBminv : G →L[ℂ] G)
    (p : Polynomial ℂ) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (hqn : ∀ x : F, ∃ y : F, qX (Vn x) = Vn y)
    (hqm : ∀ x : G, ∃ y : G, qX (Vm x) = Vm y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBrn : (compress Vn qX).comp qBninv = ContinuousLinearMap.id ℂ F)
    (hqBrm : (compress Vm qX).comp qBminv = ContinuousLinearMap.id ℂ G)
    (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))
      = Vn ((Polynomial.aeval (compress Vn X) p) (qBninv ((adjoint Vn) v))) := by sorry
