-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiAnnih₁_sq
import Mathlib
import Definitions.Def_ChapterSpinStatistics
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiAnnih1 * fermiAnnih1 = 0 := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]
