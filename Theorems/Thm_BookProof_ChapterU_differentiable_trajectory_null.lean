-- Generated from ChapterU.lean — theorem BookProof.ChapterU.differentiable_trajectory_null
import Mathlib
import Definitions.Def_ChapterU
open BookProof.ChapterU

variable {X : Type*} [MeasurableSpace X]
variable (R M N : Type*) [CommRing R] [AddCommGroup M] [Module R M]
  [AddCommGroup N] [Module R N]
variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

theorem BookProof.ChapterU.differentiable_trajectory_null {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    [IsProbabilityMeasure P] (path : Ω → ℝ → ℝ)
    (hext : ∀ᵐ ω ∂P, ∀ t, ¬ DifferentiableAt ℝ (path ω) t) :
    P {ω | ∃ t, DifferentiableAt ℝ (path ω) t} = 0 := by sorry
