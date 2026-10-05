-- Generated from ChapterGravityInvMetric.lean — solution of BookProof.ChapterGravityInvMetric.metric_mul_metric
import Mathlib
import Definitions.Def_ChapterGravityInvMetric
open BookProof.ChapterGravityInvMetric




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric

set_option maxHeartbeats 1000000 in
theorem solution : metric * metric = 1 := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [ metric ] ;
