-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermi_CAR2
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate2_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiAnnih2 * fermiCreate2 + fermiCreate2 * fermiAnnih2 = 1 := by

  rw [fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih2]
