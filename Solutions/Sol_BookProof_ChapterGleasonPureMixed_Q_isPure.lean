-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.Q_isPure
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsPureState Q := by

  refine ⟨?_, ?_, ?_⟩
  · ext i j; fin_cases i <;> fin_cases j <;> simp [Q]
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [Q, Matrix.mul_apply, Fin.sum_univ_two] <;> norm_num
  · simp [Q, Matrix.trace, Fin.sum_univ_two]; norm_num
