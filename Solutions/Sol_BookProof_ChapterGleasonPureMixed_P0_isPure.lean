-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.P0_isPure
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsPureState P0 := by

  refine ⟨?_, ?_, ?_⟩
  · ext i j; fin_cases i <;> fin_cases j <;> simp [P0]
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [P0, Matrix.mul_apply, Fin.sum_univ_two]
  · simp [P0, Matrix.trace, Fin.sum_univ_two]
