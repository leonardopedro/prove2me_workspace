-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.spatialMetric_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.spatialMetric_transpose (v : Fin 4 → ℝ) :
    (metric + vecMulVec v v)ᵀ = metric + vecMulVec v v := by sorry
