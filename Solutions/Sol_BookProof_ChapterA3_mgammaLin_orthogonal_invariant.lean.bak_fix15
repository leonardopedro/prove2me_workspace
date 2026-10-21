-- Generated from ChapterPauliCommutant.lean — solution of BookProof.ChapterA3.mgammaLin_orthogonal_invariant
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Theorems.Thm_BookProof_ChapterA3_adjoint_mgammaLin
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {W : Submodule ℂ MajoranaSpace}
    (hW : ∀ μ, ∀ x ∈ W, mgammaLin μ x ∈ W) (μ : Fin 4) {y : MajoranaSpace} (hy : y ∈ Wᗮ) :
    mgammaLin μ y ∈ Wᗮ := by

  rw [Submodule.mem_orthogonal]
  intro u hu
  rw [← LinearMap.adjoint_inner_left (mgammaLin μ) y u, adjoint_mgammaLin]
  simp only [LinearMap.smul_apply, inner_smul_left]
  rw [(Submodule.mem_orthogonal W y).mp hy _ (hW μ u hu)]
  ring
