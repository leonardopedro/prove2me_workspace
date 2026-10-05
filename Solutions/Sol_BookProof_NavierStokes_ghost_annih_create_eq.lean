-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghost_annih_create_eq
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostCreate_eq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostAnnih * ghostCreate = !![0, 0; 0, 1] := by

  rw [ghostCreate_eq]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, Matrix.mul_apply, Fin.sum_univ_two]
