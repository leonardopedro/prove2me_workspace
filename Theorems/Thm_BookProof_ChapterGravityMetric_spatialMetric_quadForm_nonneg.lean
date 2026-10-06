-- Generated from ChapterGravityMetric.lean — theorem BookProof.ChapterGravityMetric.spatialMetric_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterGravityMetric
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityMetric.spatialMetric_quadForm_nonneg (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    0 ≤ x ⬝ᵥ ((spatialMetric v).mulVec x) := by sorry
