-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiNumber₁_idem
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiNumber₁_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiNumber1 * fermiNumber1 = fermiNumber1 := by

  rw [fermiNumber₁_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp
