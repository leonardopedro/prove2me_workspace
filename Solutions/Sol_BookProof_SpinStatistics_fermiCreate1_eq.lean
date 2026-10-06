-- Generated from ChapterSpinStatistics.lean — solution of BookProof.SpinStatistics.fermiCreate1_eq
import Mathlib
import Definitions.Def_ChapterSpinStatistics
open BookProof.SpinStatistics




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : fermiCreate1 = !![0,0,0,0; 0,0,0,0; 1,0,0,0; 0,1,0,0] := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [fermiCreate1, fermiAnnih1, Matrix.conjTranspose_apply]
