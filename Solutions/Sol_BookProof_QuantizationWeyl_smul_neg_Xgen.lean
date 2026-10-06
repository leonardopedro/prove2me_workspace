-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.smul_neg_Xgen
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) : -(a • Xgen) = Ngen (-a) 0 0 := by

  unfold Xgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp
