-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_band_refinement_poly
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_band_refinement_poly (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (p : Polynomial ℂ) (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))
      = Vn ((Polynomial.aeval (compress Vn X) p) ((adjoint Vn) v)) := by sorry
