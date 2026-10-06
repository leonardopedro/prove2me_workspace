-- Generated from ChapterGravityProjector.lean — theorem BookProof.ChapterGravityProjector.spatialProj_mulVec_self
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityProjector.spatialProj_mulVec_self (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).mulVec v = 0 := by sorry
