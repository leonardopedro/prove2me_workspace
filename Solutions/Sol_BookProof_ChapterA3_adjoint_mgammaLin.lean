-- Generated from ChapterPauliCommutant.lean — solution of BookProof.ChapterA3.adjoint_mgammaLin
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Theorems.Thm_BookProof_ChapterA3_mgamma_conjTranspose
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    LinearMap.adjoint (mgammaLin μ) = (if μ = 0 then (-1 : ℂ) else 1) • mgammaLin μ := by

  rw [mgammaLin, ← Matrix.toEuclideanLin_conjTranspose_eq_adjoint, mgamma_conjTranspose]
  split_ifs <;> simp []
