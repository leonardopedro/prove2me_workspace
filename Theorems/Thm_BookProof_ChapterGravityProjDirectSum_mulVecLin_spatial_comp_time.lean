-- Generated from ChapterGravityProjDirectSum.lean — theorem BookProof.ChapterGravityProjDirectSum.mulVecLin_spatial_comp_time
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

theorem BookProof.ChapterGravityProjDirectSum.mulVecLin_spatial_comp_time (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).mulVecLin.comp (timeProj v).mulVecLin = 0 := by sorry
