-- Generated from ChapterGravityTimeProj.lean — theorem BookProof.ChapterGravityTimeProj.timeProj_idempotent
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityTimeProj.timeProj_idempotent (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    timeProj v * timeProj v = timeProj v := by sorry
