-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_adjoint_intertwine
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_compress
import Theorems.Thm_BookProof_ChapterH8_compress_comp_intertwine
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y) :
    (adjoint J).comp (compress Vm X) = (compress Vn X).comp (adjoint J) := by

  have h := compress_comp_intertwine Vn Vm J (adjoint X) hJ hVm hJJ hinvadj
  have h2 := congrArg ContinuousLinearMap.adjoint h
  rw [adjoint_comp, adjoint_comp, adjoint_compress, adjoint_compress, adjoint_adjoint] at h2
  exact h2
