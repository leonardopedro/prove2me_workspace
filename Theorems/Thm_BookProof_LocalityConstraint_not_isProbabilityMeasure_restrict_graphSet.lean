-- Generated from ChapterLocalityConstraintNull.lean — theorem BookProof.LocalityConstraint.not_isProbabilityMeasure_restrict_graphSet
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
open BookProof.LocalityConstraint

variable {α : Type*} [MeasurableSpace α]



open MeasureTheory ProbabilityTheory
open scoped NNReal


theorem BookProof.LocalityConstraint.not_isProbabilityMeasure_restrict_graphSet (μ : Measure α) (ν : Measure ℝ)
    [SFinite ν] [NullSingletonClass ν] {f : α → ℝ} (hf : Measurable f) :
    ¬ IsProbabilityMeasure ((μ.prod ν).restrict (graphSet f)) := by sorry
