-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.lintegral_bornDensity
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure


open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterBornMeasure.lintegral_bornDensity (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    ∫⁻ x, ‖(psi : α → ℂ) x‖ₑ ^ 2 ∂μ = 1 := by sorry
