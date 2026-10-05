-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostNumber_idem
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostNumber_eq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostNumber * ghostNumber = ghostNumber := by

  rw [ghostNumber_eq]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two]
