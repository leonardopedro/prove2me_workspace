-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermi_CAR_cross
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate2_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiAnnih1 * fermiCreate2 + fermiCreate2 * fermiAnnih1 = 0 := by

  rw [fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]
