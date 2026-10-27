-- Generated from ChapterPauliCommutant.lean — solution of BookProof.ChapterA3.mgamma_conjTranspose
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Theorems.Thm_BookProof_ChapterA3_mgammaZ_transpose
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    (mgamma μ)ᴴ = (if μ = 0 then (-1 : ℂ) else 1) • mgamma μ := by

  ext i j
  have h := congrFun (congrFun (mgammaZ_transpose μ) i) j
  simp only [Matrix.transpose_apply, Matrix.smul_apply, smul_eq_mul] at h
  simp only [mgamma, RingHom.mapMatrix_apply, Matrix.conjTranspose_apply, Matrix.map_apply,
    Matrix.smul_apply, smul_eq_mul, eq_intCast, Complex.star_def]
  rw [h]
  split_ifs <;> push_cast <;> simp
