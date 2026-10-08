-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.bornMeasure_apply
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure


open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterBornMeasure.bornMeasure_apply (psi : Lp ℂ 2 μ) {s : Set α} (hs : MeasurableSet s) :
    bornMeasure psi s = ∫⁻ x in s, ‖(psi : α → ℂ) x‖ₑ ^ 2 ∂μ := by sorry
