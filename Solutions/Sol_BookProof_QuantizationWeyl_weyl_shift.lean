-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.weyl_shift
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
import Theorems.Thm_BookProof_QuantizationWeyl_Heis_mul
import Theorems.Thm_BookProof_QuantizationWeyl_exp_Ngen
import Theorems.Thm_BookProof_QuantizationWeyl_smul_Xgen
import Theorems.Thm_BookProof_QuantizationWeyl_smul_Ygen
import Theorems.Thm_BookProof_QuantizationWeyl_sum_YZ
import Theorems.Thm_BookProof_QuantizationWeyl_smul_neg_Xgen
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) :
    NormedSpace.exp (a • Xgen) * NormedSpace.exp (b • Ygen) * NormedSpace.exp (-(a • Xgen))
      = NormedSpace.exp (b • Ygen + (a * b) • Zgen) := by

  rw [sum_YZ, smul_neg_Xgen, smul_Xgen, smul_Ygen,
    exp_Ngen, exp_Ngen, exp_Ngen, exp_Ngen, Heis_mul, Heis_mul]
  norm_num
