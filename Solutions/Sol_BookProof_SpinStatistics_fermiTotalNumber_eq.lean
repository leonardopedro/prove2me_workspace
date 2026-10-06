-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiTotalNumber_eq
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiNumber₁_eq
import Theorems.Thm_BookProof_SpinStatistics_fermiNumber₂_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    fermiNumber1 + fermiNumber2 = !![0,0,0,0; 0,1,0,0; 0,0,1,0; 0,0,0,2] := by

  rw [fermiNumber₁_eq, fermiNumber₂_eq]
  ext i j; fin_cases i <;> fin_cases j <;> norm_num
