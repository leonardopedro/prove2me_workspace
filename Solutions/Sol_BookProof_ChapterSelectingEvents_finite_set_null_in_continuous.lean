-- Generated from ChapterSelectingEvents.lean — solution of BookProof.ChapterSelectingEvents.finite_set_null_in_continuous
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents



open scoped BigOperators
open MeasureTheory ProbabilityTheory


variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [NullSingletonClass μ] (s : Finset α) : μ (s : Set α) = 0 := Finset.measure_zero s μ
