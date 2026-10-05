-- Generated from ChapterGravityProjDirectSum.lean — theorem BookProof.ChapterGravityProjDirectSum.mulVecLin_time_comp_spatial
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

theorem BookProof.ChapterGravityProjDirectSum.mulVecLin_time_comp_spatial (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (timeProj v).mulVecLin.comp (spatialProj v).mulVecLin = 0 := by sorry
