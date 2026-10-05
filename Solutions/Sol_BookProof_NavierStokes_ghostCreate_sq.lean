-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostCreate_sq
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostCreate_eq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostCreate * ghostCreate = 0 := by

  rw [ghostCreate_eq]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two]
