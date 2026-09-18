-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_band_refinement
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_comp_self_of_nested
import Theorems.Thm_BookProof_ChapterH8_fine_range_of_coarse
import Theorems.Thm_BookProof_ChapterH4_compress_transfer
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
    (k : ℕ) (v : E) (hv : Vn ((adjoint Vn) v) = v) :
    Vm (((compress Vm X) ^ k) ((adjoint Vm) v)) = Vn (((compress Vn X) ^ k) ((adjoint Vn) v)) := by

  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have hvm : Vm ((adjoint Vm) v) = v := fine_range_of_coarse Vn Vm J hJ hVm v hv
  have hn := compress_transfer Vn X hVn hinvn k v hv
  have hm := compress_transfer Vm X hVm hinvm k v hvm
  rw [← hm, ← hn]
