-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_approx_projection_rational
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_approx_projection_rational (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X qX : E →L[ℂ] E) (qBninv : F →L[ℂ] F) (qBminv : G →L[ℂ] G) (p : Polynomial ℂ)
    (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y)
    (hqadj : ∀ x : F, ∃ y : F, (adjoint qX) (Vn x) = Vn y)
    (hqBnl : qBninv.comp (compress Vn qX) = ContinuousLinearMap.id ℂ F)
    (hqBmr : (compress Vm qX).comp qBminv = ContinuousLinearMap.id ℂ G)
    (v : E) :
    Vn ((adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))))
      = Vn ((Polynomial.aeval (compress Vn X) p) (qBninv ((adjoint Vn) v))) := by sorry
