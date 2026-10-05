-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostCreate_eq
import Mathlib
import Definitions.Def_ChapterNavierStokes
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostCreate = !![0, 1; 0, 0] := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostCreate, ghostAnnih, Matrix.conjTranspose_apply]
