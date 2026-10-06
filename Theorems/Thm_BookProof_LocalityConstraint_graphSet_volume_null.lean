-- Generated from ChapterLocalityConstraintNull.lean — theorem BookProof.LocalityConstraint.graphSet_volume_null
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
open BookProof.LocalityConstraint

variable {α : Type*} [MeasurableSpace α]



open MeasureTheory ProbabilityTheory
open scoped NNReal


theorem BookProof.LocalityConstraint.graphSet_volume_null {f : ℝ → ℝ} (hf : Measurable f) :
    (volume : Measure (ℝ × ℝ)) (graphSet f) = 0 := by sorry
