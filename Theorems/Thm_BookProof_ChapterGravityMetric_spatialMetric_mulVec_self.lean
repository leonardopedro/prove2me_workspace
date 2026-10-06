-- Generated from ChapterGravityMetric.lean — theorem BookProof.ChapterGravityMetric.spatialMetric_mulVec_self
import Mathlib
import Definitions.Def_ChapterGravityMetric
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityMetric.spatialMetric_mulVec_self (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialMetric v).mulVec v = 0 := by sorry
