-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.spatialMetric_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_metric_transpose
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_vecMulVec_self_transpose
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    (metric + vecMulVec v v)ᵀ = metric + vecMulVec v v := by

  rw [Matrix.transpose_add, metric_transpose, vecMulVec_self_transpose]
