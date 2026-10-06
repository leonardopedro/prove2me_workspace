-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.lintegral_bornDensity
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


open MeasureTheory
open scoped ENNReal



theorem BookProof.ChapterBornMeasure.lintegral_bornDensity (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    ∫⁻ x, ‖(psi : α → ℂ) x‖ₑ ^ 2 ∂μ = 1 := by sorry
