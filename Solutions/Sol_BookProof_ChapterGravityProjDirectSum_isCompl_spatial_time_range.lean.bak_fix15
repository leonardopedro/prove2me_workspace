-- Generated from ChapterGravityProjDirectSum.lean — solution of BookProof.ChapterGravityProjDirectSum.isCompl_spatial_time_range
import Mathlib
import Definitions.Def_ChapterGravityProjDirectSum
import Theorems.Thm_BookProof_ChapterGravityProjDirectSum_isCompl_range_of_add_eq_id
import Theorems.Thm_BookProof_ChapterGravityProjDirectSum_mulVecLin_spatial_add_time
import Theorems.Thm_BookProof_ChapterGravityProjDirectSum_mulVecLin_spatial_comp_time
import Theorems.Thm_BookProof_ChapterGravityProjDirectSum_mulVecLin_time_comp_spatial
open BookProof.ChapterGravityProjDirectSum



open Matrix


open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    IsCompl (LinearMap.range (spatialProj v).mulVecLin)
      (LinearMap.range (timeProj v).mulVecLin) :=
  isCompl_range_of_add_eq_id _ _ (mulVecLin_spatial_add_time v)
      (mulVecLin_spatial_comp_time v hv) (mulVecLin_time_comp_spatial v hv)
