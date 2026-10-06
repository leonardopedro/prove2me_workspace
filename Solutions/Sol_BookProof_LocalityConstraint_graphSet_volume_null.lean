-- Generated from ChapterLocalityConstraintNull.lean — solution of BookProof.LocalityConstraint.graphSet_volume_null
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
import Theorems.Thm_BookProof_LocalityConstraint_graphSet_null
open BookProof.LocalityConstraint




open MeasureTheory ProbabilityTheory
open scoped NNReal

variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution {f : ℝ → ℝ} (hf : Measurable f) :
    (volume : Measure (ℝ × ℝ)) (graphSet f) = 0 := by

  rw [Measure.volume_eq_prod]
  exact graphSet_null _ _ hf
