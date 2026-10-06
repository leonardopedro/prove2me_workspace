-- Generated from ChapterB4.lean — solution of BookProof.ChapterB4.P1_isPureState
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4




open Matrix

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsPureState P1 := by

  refine ⟨![1, 0], by norm_num, ?_⟩
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [P1]
