-- Generated from ChapterGravityTimeProj.lean — theorem BookProof.ChapterGravityTimeProj.timeProj_mul_spatialProj
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityTimeProj.timeProj_mul_spatialProj (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    timeProj v * spatialProj v = 0 := by sorry
