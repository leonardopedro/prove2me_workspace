-- Generated from ChapterU.lean — solution of BookProof.ChapterU.differentiable_trajectory_null
import Mathlib
import Definitions.Def_ChapterU
open BookProof.ChapterU



open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    [IsProbabilityMeasure P] (path : Ω → ℝ → ℝ)
    (hext : ∀ᵐ ω ∂P, ∀ t, ¬ DifferentiableAt ℝ (path ω) t) :
    P {ω | ∃ t, DifferentiableAt ℝ (path ω) t} = 0 := by

  refine MeasureTheory.measure_mono_null (fun ω hω => ?_) hext
  aesop
