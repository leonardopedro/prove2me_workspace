-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.Ngen_eq
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution (a b c : ℝ) : a • Xgen + b • Ygen + c • Zgen = Ngen a b c := by

  unfold Xgen Ygen Zgen Ngen; ext i j; fin_cases i <;> fin_cases j <;> simp
