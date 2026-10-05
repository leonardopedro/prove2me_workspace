-- Generated from ChapterGravityInvMetric.lean — theorem BookProof.ChapterGravityInvMetric.invSpatialMetric_mulVec_lower_self
import Definitions.Def_ChapterGravityMetric
import Mathlib
import Definitions.Def_ChapterGravityInvMetric
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityInvMetric



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric

theorem BookProof.ChapterGravityInvMetric.invSpatialMetric_mulVec_lower_self (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (invSpatialMetric v).mulVec (lower v) = 0 := by sorry
