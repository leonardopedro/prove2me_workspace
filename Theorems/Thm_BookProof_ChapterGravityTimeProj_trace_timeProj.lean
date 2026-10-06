-- Generated from ChapterGravityTimeProj.lean — theorem BookProof.ChapterGravityTimeProj.trace_timeProj
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityTimeProj.trace_timeProj (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (timeProj v).trace = 1 := by sorry
