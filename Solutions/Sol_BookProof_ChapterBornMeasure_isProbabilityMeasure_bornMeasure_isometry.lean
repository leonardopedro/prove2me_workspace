-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.isProbabilityMeasure_bornMeasure_isometry
import Mathlib
import Definitions.Def_ChapterBornMeasure
import Theorems.Thm_BookProof_ChapterBornMeasure_isProbabilityMeasure_bornMeasure
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (U : Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)
    (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) : IsProbabilityMeasure (bornMeasure (U psi)) := isProbabilityMeasure_bornMeasure _ (by rw [U.norm_map, hpsi])
