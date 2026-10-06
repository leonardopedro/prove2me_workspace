-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.sum_YZ
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) : b • Ygen + (a * b) • Zgen = Ngen 0 b (a * b) := by

  unfold Ygen Zgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp
