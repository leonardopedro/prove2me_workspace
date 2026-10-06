-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.trace_metric_mul_spatialMetric
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.trace_metric_mul_spatialMetric (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (metric * (metric + vecMulVec v v)).trace = 3 := by sorry
