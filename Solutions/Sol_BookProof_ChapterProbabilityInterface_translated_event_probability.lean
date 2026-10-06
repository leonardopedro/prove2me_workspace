-- Generated from ChapterProbabilityInterface.lean — solution of BookProof.ChapterProbabilityInterface.translated_event_probability
import Mathlib
import Definitions.Def_ChapterProbabilityInterface
open BookProof.ChapterProbabilityInterface



open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X)
    (s : Set Y) (hs : MeasurableSet s) :
    transportMeasure e μ s = μ (e ⁻¹' s) := by

  rw [transportMeasure, MeasureTheory.Measure.map_apply e.measurable hs]
