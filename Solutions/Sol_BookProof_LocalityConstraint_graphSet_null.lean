-- Generated from ChapterLocalityConstraintNull.lean — solution of BookProof.LocalityConstraint.graphSet_null
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
import Theorems.Thm_BookProof_LocalityConstraint_measurableSet_graphSet
open BookProof.LocalityConstraint




open MeasureTheory ProbabilityTheory
open scoped NNReal

variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) (ν : Measure ℝ) [SFinite ν] [NullSingletonClass ν]
    {f : α → ℝ} (hf : Measurable f) :
    (μ.prod ν) (graphSet f) = 0 := by

  refine Measure.measure_prod_null_of_ae_null (measurableSet_graphSet hf) ?_
  filter_upwards with x
  simp
