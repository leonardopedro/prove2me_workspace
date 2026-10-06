-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.bornMeasure_univ
import Mathlib
import Definitions.Def_ChapterBornMeasure
import Theorems.Thm_BookProof_ChapterBornMeasure_bornMeasure_apply
import Theorems.Thm_BookProof_ChapterBornMeasure_lintegral_bornDensity
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    bornMeasure psi Set.univ = 1 := by

  rw [bornMeasure_apply psi MeasurableSet.univ, Measure.restrict_univ,
    lintegral_bornDensity psi hpsi]
