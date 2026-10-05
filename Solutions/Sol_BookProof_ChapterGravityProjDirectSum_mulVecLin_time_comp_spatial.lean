-- Generated from ChapterGravityProjDirectSum.lean — solution of BookProof.ChapterGravityProjDirectSum.mulVecLin_time_comp_spatial
import Mathlib
import Definitions.Def_ChapterGravityProjDirectSum
open BookProof.ChapterGravityProjDirectSum



open Matrix


open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (timeProj v).mulVecLin.comp (spatialProj v).mulVecLin = 0 := by

  rw [← Matrix.mulVecLin_mul, timeProj_mul_spatialProj v hv, Matrix.mulVecLin_zero]
