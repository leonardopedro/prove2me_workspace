-- Generated from ChapterGravitySplit.lean — theorem BookProof.ChapterGravitySplit.spatialPart_add_timePart
import Mathlib
import Definitions.Def_ChapterGravitySplit
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj
open BookProof.ChapterGravitySplit



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

theorem BookProof.ChapterGravitySplit.spatialPart_add_timePart (v x : Fin 4 → ℝ) :
    spatialPart v x + timePart v x = x := by sorry
