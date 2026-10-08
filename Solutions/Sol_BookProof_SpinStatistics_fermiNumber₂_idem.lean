-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiNumber2_idem
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiNumber2_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiNumber2 * fermiNumber2 = fermiNumber2 := by

  rw [fermiNumber2_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp
