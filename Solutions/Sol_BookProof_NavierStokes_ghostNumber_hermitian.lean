-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostNumber_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostNumber_eq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostNumberᴴ = ghostNumber := by

  rw [ghostNumber_eq]
  ext i j; fin_cases i <;> fin_cases j <;> simp [Matrix.conjTranspose_apply]
