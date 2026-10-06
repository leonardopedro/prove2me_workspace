-- Generated from ChapterProbabilityInterface.lean — theorem BookProof.ChapterProbabilityInterface.translated_event_probability
import Mathlib
import Definitions.Def_ChapterProbabilityInterface
open BookProof.ChapterProbabilityInterface


open MeasureTheory

theorem BookProof.ChapterProbabilityInterface.translated_event_probability {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X)
    (s : Set Y) (hs : MeasurableSet s) :
    transportMeasure e μ s = μ (e ⁻¹' s) := by sorry
