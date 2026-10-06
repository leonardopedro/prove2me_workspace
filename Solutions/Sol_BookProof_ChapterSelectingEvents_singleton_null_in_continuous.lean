-- Generated from ChapterSelectingEvents.lean — solution of BookProof.ChapterSelectingEvents.singleton_null_in_continuous
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents



open scoped BigOperators
open MeasureTheory ProbabilityTheory


variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [NullSingletonClass μ] (x : α) : μ {x} = 0 := NullSingletonClass.measure_singleton x
