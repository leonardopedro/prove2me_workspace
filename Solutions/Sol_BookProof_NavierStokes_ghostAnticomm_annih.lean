-- Generated from ChapterNavierStokes.lean — solution of BookProof.NavierStokes.ghostAnticomm_annih
import Mathlib
import Definitions.Def_ChapterNavierStokes
import Theorems.Thm_BookProof_NavierStokes_ghostAnnih_sq
open BookProof.NavierStokes




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ghostAnnih * ghostAnnih + ghostAnnih * ghostAnnih = 0 := by

  rw [ghostAnnih_sq]; simp
