-- Generated from ChapterLocalityConstraintNull.lean — solution of BookProof.LocalityConstraint.graphSet_gaussian_null
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
import Theorems.Thm_BookProof_LocalityConstraint_graphSet_null
open BookProof.LocalityConstraint




open MeasureTheory ProbabilityTheory
open scoped NNReal

variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (m₁ m₂ : ℝ) (v₁ : ℝ≥0) (v₂ : ℝ≥0) (hv₂ : v₂ ≠ 0)
    {f : ℝ → ℝ} (hf : Measurable f) :
    ((gaussianReal m₁ v₁).prod (gaussianReal m₂ v₂)) (graphSet f) = 0 := by

  have : NullSingletonClass (gaussianReal m₂ v₂) := nullSingletonClass_gaussianReal hv₂
  exact graphSet_null _ _ hf
