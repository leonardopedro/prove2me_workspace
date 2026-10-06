-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.trace_metric_mul_of_antisymm
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.trace_metric_mul_of_antisymm {M : Matrix (Fin 4) (Fin 4) ℝ} (hM : Mᵀ = -M) :
    (metric * M).trace = 0 := by sorry
