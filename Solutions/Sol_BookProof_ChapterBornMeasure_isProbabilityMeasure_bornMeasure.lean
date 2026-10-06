-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.isProbabilityMeasure_bornMeasure
import Mathlib
import Definitions.Def_ChapterBornMeasure
import Theorems.Thm_BookProof_ChapterBornMeasure_bornMeasure_univ
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    IsProbabilityMeasure (bornMeasure psi) := ⟨bornMeasure_univ psi hpsi⟩
