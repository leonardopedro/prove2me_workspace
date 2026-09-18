-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_approx_projection_rational
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_comp_nested
import Theorems.Thm_BookProof_ChapterH8_compress_adjoint_intertwine
import Theorems.Thm_BookProof_ChapterH8_compress_adjoint_intertwine_poly
import Theorems.Thm_BookProof_ChapterH8_inv_comp_intertwine
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
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
      = Vn ((Polynomial.aeval (compress Vn X) p) (qBninv ((adjoint Vn) v))) := by

  have hproj : (adjoint Vn).comp Vm = adjoint J := adjoint_comp_nested Vn Vm J hJ hVm
  have hqi : (adjoint J).comp qBminv = qBninv.comp (adjoint J) :=
    inv_comp_intertwine (adjoint J) hqBnl hqBmr
      (compress_adjoint_intertwine Vn Vm J qX hJ hVm hJJ hqadj)
  have hpi := compress_adjoint_intertwine_poly Vn Vm J X hJ hVm hJJ hinvadj p
  have h3 : (adjoint J) ((adjoint Vm) v) = (adjoint Vn) v := by
    have hsplit : (adjoint Vn) = (adjoint J).comp (adjoint Vm) := by rw [hJ, adjoint_comp]
    rw [hsplit]
    rfl
  have h1 : (adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v))))
      = (adjoint J) ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v))) :=
    congrArg (fun f : G →L[ℂ] F => f
      ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))) hproj
  have h2 : (adjoint J) ((Polynomial.aeval (compress Vm X) p) (qBminv ((adjoint Vm) v)))
      = (Polynomial.aeval (compress Vn X) p) ((adjoint J) (qBminv ((adjoint Vm) v))) :=
    congrArg (fun f : G →L[ℂ] F => f (qBminv ((adjoint Vm) v))) hpi
  have h4 : (adjoint J) (qBminv ((adjoint Vm) v)) = qBninv ((adjoint J) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((adjoint Vm) v)) hqi
  rw [h1, h2, h4, h3]
