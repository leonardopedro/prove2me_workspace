-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiCreate₁_sq
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate1_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiCreate1 * fermiCreate1 = 0 := by

  rw [fermiCreate1_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp
