-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.singleton_null_in_continuous
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents


open scoped BigOperators
open MeasureTheory ProbabilityTheory


variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.ChapterSelectingEvents.singleton_null_in_continuous {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [NullSingletonClass μ] (x : α) : μ {x} = 0 := by sorry
