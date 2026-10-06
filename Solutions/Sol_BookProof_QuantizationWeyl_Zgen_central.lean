-- Generated from ChapterQuantizationWeyl.lean — solution of BookProof.QuantizationWeyl.Zgen_central
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl



open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

set_option maxHeartbeats 1000000 in
theorem solution : Xgen * Zgen = 0 ∧ Zgen * Xgen = 0 ∧ Ygen * Zgen = 0 ∧ Zgen * Ygen = 0 := by

  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    · first
        | (unfold Xgen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
            simp [Matrix.mul_apply, Fin.sum_univ_three])
        | (unfold Ygen Zgen; ext i j; fin_cases i <;> fin_cases j <;>
            simp [Matrix.mul_apply, Fin.sum_univ_three])
