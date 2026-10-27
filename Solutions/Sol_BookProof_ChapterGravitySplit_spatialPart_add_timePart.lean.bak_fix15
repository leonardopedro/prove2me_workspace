-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.spatialPart_add_timePart
import Mathlib
import Definitions.Def_ChapterGravitySplit
import Theorems.Thm_BookProof_ChapterGravityTimeProj_spatialProj_add_timeProj
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v x : Fin 4 → ℝ) :
    spatialPart v x + timePart v x = x := by

  unfold spatialPart timePart;
  rw [ ← Matrix.add_mulVec, BookProof.ChapterGravityTimeProj.spatialProj_add_timeProj,
      Matrix.one_mulVec ]
