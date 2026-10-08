-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.bornMeasure_univ
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure


open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


theorem BookProof.ChapterBornMeasure.bornMeasure_univ (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) :
    bornMeasure psi Set.univ = 1 := by sorry
