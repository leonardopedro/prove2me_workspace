-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_band_refinement_poly
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_comp_self_of_nested
import Theorems.Thm_BookProof_ChapterH8_fine_range_of_coarse
import Theorems.Thm_BookProof_ChapterH8_compress_aeval_transfer
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y)
    (hinvm : ∀ x : G, ∃ y : G, X (Vm x) = Vm y)
    (p : Polynomial ℂ) (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm ((Polynomial.aeval (compress Vm X) p) ((adjoint Vm) v))
      = Vn ((Polynomial.aeval (compress Vn X) p) ((adjoint Vn) v)) := by

  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have hvm : Vm ((adjoint Vm) v) = v := fine_range_of_coarse Vn Vm J hJ hVm v hv
  rw [← compress_aeval_transfer Vm X hVm hinvm p v hvm,
    ← compress_aeval_transfer Vn X hVn hinvn p v hv]
