-- Generated from ChapterLocalityConstraintNull.lean — solution of BookProof.LocalityConstraint.not_isProbabilityMeasure_restrict_graphSet
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
import Theorems.Thm_BookProof_LocalityConstraint_restrict_graphSet_eq_zero
open BookProof.LocalityConstraint




open MeasureTheory ProbabilityTheory
open scoped NNReal

variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) (ν : Measure ℝ)
    [SFinite ν] [NullSingletonClass ν] {f : α → ℝ} (hf : Measurable f) :
    ¬ IsProbabilityMeasure ((μ.prod ν).restrict (graphSet f)) := by

  intro h
  have h1 : ((μ.prod ν).restrict (graphSet f)) Set.univ = 1 := h.measure_univ
  rw [restrict_graphSet_eq_zero μ ν hf] at h1
  simp at h1
