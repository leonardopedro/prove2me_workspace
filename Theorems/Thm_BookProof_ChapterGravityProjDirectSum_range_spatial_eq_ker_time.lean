-- Generated from ChapterGravityProjDirectSum.lean — theorem BookProof.ChapterGravityProjDirectSum.range_spatial_eq_ker_time
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

theorem BookProof.ChapterGravityProjDirectSum.range_spatial_eq_ker_time (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    LinearMap.range (spatialProj v).mulVecLin
      = LinearMap.ker (timeProj v).mulVecLin := by sorry
