-- Generated from ChapterGravityProjDirectSum.lean — solution of BookProof.ChapterGravityProjDirectSum.mulVecLin_spatial_add_time
import Mathlib
import Definitions.Def_ChapterGravityProjDirectSum
import Theorems.Thm_BookProof_ChapterGravityTimeProj_spatialProj_add_timeProj
open BookProof.ChapterGravityProjDirectSum



open Matrix


open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    (spatialProj v).mulVecLin + (timeProj v).mulVecLin = LinearMap.id := by

  rw [← Matrix.mulVecLin_add, spatialProj_add_timeProj, Matrix.mulVecLin_one]
