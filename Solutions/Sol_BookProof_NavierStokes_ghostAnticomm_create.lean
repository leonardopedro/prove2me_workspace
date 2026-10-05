-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostAnticomm_create
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostCreate_sq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    ghostCreate * ghostCreate + ghostCreate * ghostCreate = 0 := by

  rw [ghostCreate_sq]; simp
