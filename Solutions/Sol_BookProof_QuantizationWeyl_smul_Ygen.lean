-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.smul_Ygen
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (b : ℝ) : b • Ygen = Ngen 0 b 0 := by

  unfold Ygen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp
