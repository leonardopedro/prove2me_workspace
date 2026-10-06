-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiAnticomm_create
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate1_eq
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate2_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    fermiCreate1 * fermiCreate2 + fermiCreate2 * fermiCreate1 = 0 := by

  rw [fermiCreate1_eq, fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp
