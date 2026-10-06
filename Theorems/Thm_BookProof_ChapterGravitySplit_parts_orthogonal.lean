-- Generated from ChapterGravitySplit.lean — theorem BookProof.ChapterGravitySplit.parts_orthogonal
import Definitions.Def_ChapterGravityTimeProj
import Mathlib
import Definitions.Def_ChapterGravitySplit
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravitySplit



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

theorem BookProof.ChapterGravitySplit.parts_orthogonal (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    minkForm (spatialPart v x) (timePart v x) = 0 := by sorry
