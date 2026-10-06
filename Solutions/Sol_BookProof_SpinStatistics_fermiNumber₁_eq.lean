-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiNumber₁_eq
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiCreate1_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiNumber1 = !![0,0,0,0; 0,0,0,0; 0,0,1,0; 0,0,0,1] := by

  rw [fermiNumber1, fermiCreate1_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [fermiAnnih1]
