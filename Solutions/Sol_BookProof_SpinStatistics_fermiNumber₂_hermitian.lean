-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiNumber2_hermitian
import Mathlib
import Definitions.Def_ChapterSpinStatistics
import Theorems.Thm_BookProof_SpinStatistics_fermiNumber2_eq
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiNumber2ᴴ = fermiNumber2 := by

  rw [fermiNumber2_eq]; ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.conjTranspose_apply]
