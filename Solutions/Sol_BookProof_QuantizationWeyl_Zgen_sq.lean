-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.Zgen_sq
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution : Zgen ^ 2 = 0 := by

  unfold Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp [pow_succ, Matrix.mul_apply, Fin.sum_univ_three]
