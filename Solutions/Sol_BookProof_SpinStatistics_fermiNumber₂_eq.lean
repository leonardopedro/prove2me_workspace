-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiNumber2_eq
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate2_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiNumber2 = !![0,0,0,0; 0,1,0,0; 0,0,0,0; 0,0,0,1] := by

  rw [fermiNumber2, fermiCreate2_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih2]
