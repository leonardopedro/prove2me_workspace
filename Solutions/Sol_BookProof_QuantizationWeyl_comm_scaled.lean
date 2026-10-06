-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.comm_scaled
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) :
    (a • Xgen) * (b • Ygen) - (b • Ygen) * (a • Xgen) = (a * b) • Zgen := by

  unfold Xgen Ygen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
    simp
