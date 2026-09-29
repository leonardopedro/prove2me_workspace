-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_approx_projection_poly
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_comp_nested
import Theorems.Thm_BookProof_ChapterH8_compress_adjoint_intertwine_poly
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y)
    (p : Polynomial ℂ) (v : E) :
    Vn ((adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))))
      = Vn ((Polynomial.aeval (compress Vn X) p) ((adjoint Vn) v)) := by

  have hadj := compress_adjoint_intertwine_poly Vn Vm J X hJ hVm hJJ hinvadj p
  have hproj : (adjoint Vn).comp Vm = adjoint J := adjoint_comp_nested Vn Vm J hJ hVm
  have h1 : (adjoint Vn) (Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v)))
      = (adjoint J) ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))) hproj
  have h2 : (adjoint J) ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))
      = (Polynomial.aeval (compress Vn X) p) ((adjoint J) ((adjoint Vm) v)) :=
    congrArg (fun f : G →L[ℂ] F => f ((adjoint Vm) v)) hadj
  have h3 : (adjoint J) ((adjoint Vm) v) = (adjoint Vn) v := by
    have hsplit : (adjoint Vn) = (adjoint J).comp (adjoint Vm) := by rw [hJ, adjoint_comp]
    rw [hsplit]
    rfl
  rw [h1, h2, h3]
