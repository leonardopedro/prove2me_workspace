-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.metric_mul_metric
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution : metric * metric = (1 : Matrix (Fin 4) (Fin 4) ℝ) := by

  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [metric, Matrix.mul_apply, Matrix.diagonal]
