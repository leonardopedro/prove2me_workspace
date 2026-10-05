-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostNumber_eq
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostCreate_eq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostNumber = !![1, 0; 0, 0] := by

  rw [ghostNumber, ghostCreate_eq]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, Matrix.mul_apply, Fin.sum_univ_two]
