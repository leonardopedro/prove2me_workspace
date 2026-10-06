-- Generated from ChapterGravityMetric.lean — theorem BookProof.ChapterGravityMetric.spatialMetric_posSemidef
import Mathlib
import Definitions.Def_ChapterGravityMetric
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityMetric.spatialMetric_posSemidef (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialMetric v).PosSemidef := by sorry
