-- Generated from ChapterMeasurementLLN.lean — solution of BookProof.ChapterMeasurementLLN.measurement_frequency_tendsto
import Mathlib
import Definitions.Def_ChapterMeasurementLLN
import Theorems.Thm_BookProof_ChapterMeasurementLLN_outcomeIndicator_integral
import Theorems.Thm_BookProof_ChapterMeasurementLLN_measurement_average_tendsto
open BookProof.ChapterMeasurementLLN



open MeasureTheory ProbabilityTheory
open scoped ENNReal


variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
variable {k : ℕ}

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
variable {k : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M : ℕ → Ω → Fin k) (a : Fin k)
    (hmeas : ∀ i, Measurable (M i))
    (hindep : Pairwise (fun i j => IndepFun (M i) (M j) μ))
    (hident : ∀ i, IdentDistrib (M i) (M 0) μ μ) :
    ∀ᵐ ω ∂μ, Filter.Tendsto
      (fun n => (∑ i ∈ Finset.range n, outcomeIndicator M a i ω) / n)
      Filter.atTop (nhds (μ {ω | M 0 ω = a}).toReal) := by

  -- Specialize the general observable version to the indicator of outcome `a`
  -- and identify its expectation with the outcome probability.
  have hint := measurement_average_tendsto M (fun b => if b = a then (1 : ℝ) else 0)
    hmeas hindep hident
  rw [← outcomeIndicator_integral M a (hmeas 0)]
  exact hint
