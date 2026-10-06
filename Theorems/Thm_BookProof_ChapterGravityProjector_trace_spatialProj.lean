-- Generated from ChapterGravityProjector.lean — theorem BookProof.ChapterGravityProjector.trace_spatialProj
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityProjector.trace_spatialProj (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).trace = 3 := by sorry
