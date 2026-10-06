-- Generated from ChapterMeasurementLLN.lean — theorem BookProof.ChapterMeasurementLLN.outcomeIndicator_integral
import Mathlib
import Definitions.Def_ChapterMeasurementLLN
open BookProof.ChapterMeasurementLLN

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
variable {k : ℕ}


open MeasureTheory ProbabilityTheory
open scoped ENNReal



theorem BookProof.ChapterMeasurementLLN.outcomeIndicator_integral (M : ℕ → Ω → Fin k) (a : Fin k)
    (hM : Measurable (M 0)) :
    ∫ ω, outcomeIndicator M a 0 ω ∂μ = (μ {ω | M 0 ω = a}).toReal := by sorry
