-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.bornMeasure_absolutelyContinuous
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (psi : Lp ℂ 2 μ) : bornMeasure psi ≪ μ := withDensity_absolutelyContinuous _ _
