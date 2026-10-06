-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.metric_mulVec_lower
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_metric_mul_metric
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) : metric.mulVec (lower v) = v := by

  calc metric.mulVec (lower v) = (metric * metric).mulVec v := by
        simp [lower, Matrix.mulVec_mulVec]
    _ = v := by simp [metric_mul_metric]
