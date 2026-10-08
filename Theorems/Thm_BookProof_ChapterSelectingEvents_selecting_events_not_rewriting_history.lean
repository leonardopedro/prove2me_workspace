-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.selecting_events_not_rewriting_history
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents


open scoped BigOperators
open MeasureTheory ProbabilityTheory


variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {Ω Data : Type*} [MeasurableSpace Ω]
variable {X : Type*} [MeasurableSpace X] (μ : Measure X) [IsProbabilityMeasure μ]
variable {Seed Model : Type*} [Fintype Seed] [Fintype Model] [DecidableEq Model]

theorem BookProof.ChapterSelectingEvents.selecting_events_not_rewriting_history
    {α : Type*} [MeasurableSpace α] [StandardBorelSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] [NullSingletonClass μ]
    (E F : Set α) (_hE : MeasurableSet E) (hF : MeasurableSet F)
    (_hEpos : μ E > 0) (_hFpos : μ F > 0) :
    μ[F | E] = μ (E ∩ F) / μ E := by sorry
