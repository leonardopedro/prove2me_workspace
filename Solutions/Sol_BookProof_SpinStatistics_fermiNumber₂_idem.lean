-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiNumber₂_idem
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiNumber₂_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiNumber2 * fermiNumber2 = fermiNumber2 := by

  rw [fermiNumber₂_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp
