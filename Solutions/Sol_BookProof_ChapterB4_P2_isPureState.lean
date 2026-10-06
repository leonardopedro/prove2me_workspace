-- Generated from ChapterB4.lean — solution of BookProof.ChapterB4.P2_isPureState
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4




open Matrix

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsPureState P2 := by

  have hmul : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  refine ⟨![Real.sqrt 2 / 2, Real.sqrt 2 / 2], ?_, ?_⟩
  · simp only [Matrix.cons_val_zero, Matrix.cons_val_one]
    nlinarith [hmul]
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [P2] <;> nlinarith [hmul]
