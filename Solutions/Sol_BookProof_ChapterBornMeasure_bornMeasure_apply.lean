-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.bornMeasure_apply
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (psi : Lp ℂ 2 μ) {s : Set α} (hs : MeasurableSet s) :
    bornMeasure psi s = ∫⁻ x in s, ‖(psi : α → ℂ) x‖ₑ ^ 2 ∂μ := by

  rw [bornMeasure, withDensity_apply _ hs]
  rfl
