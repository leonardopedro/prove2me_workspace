-- Generated from ChapterProbabilityInterface.lean — solution of BookProof.ChapterProbabilityInterface.transportMeasure_isProbability
import Mathlib
import Definitions.Def_ChapterProbabilityInterface
open BookProof.ChapterProbabilityInterface



open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X)
    [IsProbabilityMeasure μ] : IsProbabilityMeasure (transportMeasure e μ) := by

  exact Measure.isProbabilityMeasure_map e.measurable.aemeasurable
