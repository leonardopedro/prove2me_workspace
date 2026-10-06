-- Generated from ChapterGravitySplit.lean — theorem BookProof.ChapterGravitySplit.split_unique
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

theorem BookProof.ChapterGravitySplit.split_unique (v x s : Fin 4 → ℝ) (c : ℝ) (hv : minkSq v = -1)
    (hs : minkForm s v = 0) (hx : x = s + c • v) :
    s = spatialPart v x ∧ c • v = timePart v x := by sorry
