-- Generated from ChapterLocalityConstraintNull.lean — theorem BookProof.LocalityConstraint.graphSet_gaussian_null
import Mathlib
import Definitions.Def_ChapterLocalityConstraintNull
open BookProof.LocalityConstraint

variable {α : Type*} [MeasurableSpace α]



open MeasureTheory ProbabilityTheory
open scoped NNReal


theorem BookProof.LocalityConstraint.graphSet_gaussian_null (m₁ m₂ : ℝ) (v₁ : ℝ≥0) (v₂ : ℝ≥0) (hv₂ : v₂ ≠ 0)
    {f : ℝ → ℝ} (hf : Measurable f) :
    ((gaussianReal m₁ v₁).prod (gaussianReal m₂ v₂)) (graphSet f) = 0 := by sorry
