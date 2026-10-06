-- Generated from ChapterGravityProjector.lean — theorem BookProof.ChapterGravityProjector.spatialProj_idempotent
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityProjector.spatialProj_idempotent (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    spatialProj v * spatialProj v = spatialProj v := by sorry
