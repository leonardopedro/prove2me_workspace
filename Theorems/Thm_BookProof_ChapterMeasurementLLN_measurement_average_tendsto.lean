-- Generated from ChapterMeasurementLLN.lean — theorem BookProof.ChapterMeasurementLLN.measurement_average_tendsto
import Mathlib
import Definitions.Def_ChapterMeasurementLLN
open BookProof.ChapterMeasurementLLN

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
variable {k : ℕ}


open MeasureTheory ProbabilityTheory
open scoped ENNReal



theorem BookProof.ChapterMeasurementLLN.measurement_average_tendsto (M : ℕ → Ω → Fin k) (f : Fin k → ℝ)
    (hmeas : ∀ i, Measurable (M i))
    (hindep : Pairwise (fun i j => IndepFun (M i) (M j) μ))
    (hident : ∀ i, IdentDistrib (M i) (M 0) μ μ) :
    ∀ᵐ ω ∂μ, Filter.Tendsto
      (fun n => (∑ i ∈ Finset.range n, f (M i ω)) / n)
      Filter.atTop (nhds (∫ ω, f (M 0 ω) ∂μ)) := by sorry
