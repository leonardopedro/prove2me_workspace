-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.comm_XY
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution : Xgen * Ygen - Ygen * Xgen = Zgen := by

  unfold Xgen Ygen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp
