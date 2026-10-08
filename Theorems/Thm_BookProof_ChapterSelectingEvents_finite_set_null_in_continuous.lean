-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.finite_set_null_in_continuous
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents


open scoped BigOperators
open MeasureTheory ProbabilityTheory


variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.ChapterSelectingEvents.finite_set_null_in_continuous {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [NullSingletonClass μ] (s : Finset α) : μ (s : Set α) = 0 := by sorry
