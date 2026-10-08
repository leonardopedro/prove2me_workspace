-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.isProbabilityMeasure_bornMeasure_isometry
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure


open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterBornMeasure.isProbabilityMeasure_bornMeasure_isometry (U : Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)
    (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) : IsProbabilityMeasure (bornMeasure (U psi)) := by sorry
