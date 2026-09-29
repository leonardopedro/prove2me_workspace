-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_band_refinement_rational
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_adjoint_comp_self_of_nested
import Theorems.Thm_BookProof_ChapterH8_fine_range_of_coarse
import Theorems.Thm_BookProof_ChapterH8_compress_rational_transfer
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
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
      = Vn ((Polynomial.aeval (compress Vn X) p) (qBninv ((adjoint Vn) v))) := by

  have hVn : (adjoint Vn).comp Vn = ContinuousLinearMap.id ℂ F :=
    adjoint_comp_self_of_nested Vn Vm J hJ hVm hJJ
  have hvm : Vm ((adjoint Vm) v) = v := fine_range_of_coarse Vn Vm J hJ hVm v hv
  rw [← compress_rational_transfer Vm X qX qXinv qBminv p hVm hinvm hqm hqXl hqBrm v hvm,
    ← compress_rational_transfer Vn X qX qXinv qBninv p hVn hinvn hqn hqXl hqBrn v hv]
