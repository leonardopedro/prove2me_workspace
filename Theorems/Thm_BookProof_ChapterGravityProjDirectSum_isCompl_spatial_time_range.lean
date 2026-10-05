-- Generated from ChapterGravityProjDirectSum.lean — theorem BookProof.ChapterGravityProjDirectSum.isCompl_spatial_time_range
import Mathlib
import Definitions.Def_ChapterGravityProjDirectSum
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj
open BookProof.ChapterGravityProjDirectSum


open Matrix


open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

theorem BookProof.ChapterGravityProjDirectSum.isCompl_spatial_time_range (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    IsCompl (LinearMap.range (spatialProj v).mulVecLin)
      (LinearMap.range (timeProj v).mulVecLin) := by sorry
