-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.Ngen_cube
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a b c : ℝ) : (Ngen a b c) ^ 3 = 0 := by

  unfold Ngen; ext i j; fin_cases i <;> fin_cases j <;>
    simp [pow_succ, Matrix.mul_apply, Fin.sum_univ_three]
