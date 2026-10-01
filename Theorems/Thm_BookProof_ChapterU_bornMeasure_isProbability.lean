-- Generated from ChapterU.lean — theorem BookProof.ChapterU.bornMeasure_isProbability
import Mathlib
import Definitions.Def_ChapterU
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure
open BookProof.ChapterU

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

theorem BookProof.ChapterU.bornMeasure_isProbability (Ψ : X → ℂ) (μ : Measure X)
    (hΨ : MemLp Ψ 2 μ) (hnorm : ∫ x, ‖Ψ x‖ ^ 2 ∂μ = 1) :
    IsProbabilityMeasure (bornMeasure Ψ μ) := by sorry
