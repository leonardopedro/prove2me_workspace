-- Generated from ChapterLocalityConstraintNull.lean — solution of BookProof.LocalityConstraint.measurableSet_graphSet
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
open BookProof.LocalityConstraint




open MeasureTheory ProbabilityTheory
open scoped NNReal

variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution {f : α → ℝ} (hf : Measurable f) :
    MeasurableSet (graphSet f) := measurableSet_eq_fun measurable_snd (hf.comp measurable_fst)
