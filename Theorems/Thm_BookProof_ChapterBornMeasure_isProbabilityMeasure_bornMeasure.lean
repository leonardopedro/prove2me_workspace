-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.isProbabilityMeasure_bornMeasure
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


open MeasureTheory
open scoped ENNReal



theorem BookProof.ChapterBornMeasure.isProbabilityMeasure_bornMeasure (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    IsProbabilityMeasure (bornMeasure psi) := by sorry
