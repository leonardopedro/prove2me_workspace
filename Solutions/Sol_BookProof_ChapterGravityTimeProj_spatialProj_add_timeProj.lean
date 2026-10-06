-- Generated from ChapterGravityTimeProj.lean — solution of BookProof.ChapterGravityTimeProj.spatialProj_add_timeProj
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityTimeProj




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    spatialProj v + timeProj v = 1 := by

  ext a b; simp [ spatialProj, timeProj ] ;
