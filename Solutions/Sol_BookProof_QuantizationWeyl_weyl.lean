-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.weyl
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
import Theorems.Thm_BookProof_QuantizationWeyl_Heis_mul
import Theorems.Thm_BookProof_QuantizationWeyl_exp_Ngen
import Theorems.Thm_BookProof_QuantizationWeyl_smul_Xgen
import Theorems.Thm_BookProof_QuantizationWeyl_smul_Ygen
import Theorems.Thm_BookProof_QuantizationWeyl_sum_XYZ
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) :
    NormedSpace.exp (a • Xgen) * NormedSpace.exp (b • Ygen)
      = NormedSpace.exp (a • Xgen + b • Ygen + (a * b / 2) • Zgen) := by

  rw [sum_XYZ, smul_Xgen, smul_Ygen, exp_Ngen, exp_Ngen, exp_Ngen, Heis_mul]
  norm_num
