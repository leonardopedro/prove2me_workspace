-- Generated from ChapterGravityProjDirectSum.lean — solution of BookProof.ChapterGravityProjDirectSum.mulVecLin_spatial_comp_time
import Mathlib
import Definitions.Def_ChapterGravityProjDirectSum
open BookProof.ChapterGravityProjDirectSum



open Matrix


open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).mulVecLin.comp (timeProj v).mulVecLin = 0 := by

  rw [← Matrix.mulVecLin_mul, spatialProj_mul_timeProj v hv, Matrix.mulVecLin_zero]
