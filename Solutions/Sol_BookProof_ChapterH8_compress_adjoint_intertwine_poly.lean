-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_adjoint_intertwine_poly
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_compress
import Theorems.Thm_BookProof_ChapterH8_compress_aeval_comp_intertwine
import Theorems.Thm_BookProof_ChapterH8_adjoint_aeval
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvadj : ∀ x : F, ∃ y : F, (adjoint X) (Vn x) = Vn y) (p : Polynomial ℂ) :
    (adjoint J).comp (Polynomial.aeval (compress Vm X) p)
      = (Polynomial.aeval (compress Vn X) p).comp (adjoint J) := by

  have hpp : (p.map (starRingEnd ℂ)).map (starRingEnd ℂ) = p := by
    simp [Polynomial.map_map]
  have hstar := compress_aeval_comp_intertwine Vn Vm J (adjoint X) hJ hVm hJJ hinvadj
    (p.map (starRingEnd ℂ))
  have hadj := congrArg ContinuousLinearMap.adjoint hstar
  rw [adjoint_comp, adjoint_comp, adjoint_aeval, adjoint_aeval, adjoint_compress,
    adjoint_compress, adjoint_adjoint, hpp] at hadj
  exact hadj
