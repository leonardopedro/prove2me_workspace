-- Generated from ChapterLocalityConstraintNull.lean — theorem BookProof.LocalityConstraint.graphSet_null
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
open BookProof.LocalityConstraint



open MeasureTheory ProbabilityTheory
open scoped NNReal

variable {α : Type*} [MeasurableSpace α]


theorem BookProof.LocalityConstraint.graphSet_null (μ : Measure α) (ν : Measure ℝ) [SFinite ν] [NullSingletonClass ν]
    {f : α → ℝ} (hf : Measurable f) :
    (μ.prod ν) (graphSet f) = 0 := by sorry
