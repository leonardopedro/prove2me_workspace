-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostNumber_resolution
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghost_CAR
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostNumber + ghostAnnih * ghostCreate = 1 := by

  rw [ghostNumber, add_comm]; exact ghost_CAR
