-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostAnnih_sq
import Mathlib
import Definitions.Def_ChapterNavierStokes
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostAnnih * ghostAnnih = 0 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, Matrix.mul_apply, Fin.sum_univ_two]
