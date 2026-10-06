-- Generated from ChapterLocalityConstraintNull.lean — theorem BookProof.LocalityConstraint.measurableSet_graphSet
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
open BookProof.LocalityConstraint

variable {α : Type*} [MeasurableSpace α]



open MeasureTheory ProbabilityTheory
open scoped NNReal


theorem BookProof.LocalityConstraint.measurableSet_graphSet {f : α → ℝ} (hf : Measurable f) :
    MeasurableSet (graphSet f) := by sorry
