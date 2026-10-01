-- Generated from ChapterU.lean — solution of BookProof.ChapterU.no_differentiable_trajectory
import Mathlib
import Definitions.Def_ChapterU
open BookProof.ChapterU



open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    [IsProbabilityMeasure P] (path : Ω → ℝ → ℝ)
    (hext : ∀ᵐ ω ∂P, ∀ t, ¬ DifferentiableAt ℝ (path ω) t) :
    P {ω | ∃ t, DifferentiableAt ℝ (path ω) t}ᶜ = 1 := by

  rw [ MeasureTheory.measure_congr, IsProbabilityMeasure.measure_univ ];
  simp_all [ MeasureTheory.ae_iff ]
