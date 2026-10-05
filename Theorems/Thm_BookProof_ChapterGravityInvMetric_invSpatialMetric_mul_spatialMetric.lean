-- Generated from ChapterGravityInvMetric.lean — theorem BookProof.ChapterGravityInvMetric.invSpatialMetric_mul_spatialMetric
import Mathlib
import Definitions.Def_ChapterGravityInvMetric
import Definitions.Def_ChapterGravityMetric
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityMetric
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityInvMetric



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric

theorem BookProof.ChapterGravityInvMetric.invSpatialMetric_mul_spatialMetric (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    invSpatialMetric v * spatialMetric v = spatialProj v := by sorry
