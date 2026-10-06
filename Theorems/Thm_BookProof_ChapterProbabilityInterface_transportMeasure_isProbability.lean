-- Generated from ChapterProbabilityInterface.lean — theorem BookProof.ChapterProbabilityInterface.transportMeasure_isProbability
import Mathlib
import Definitions.Def_ChapterProbabilityInterface
open BookProof.ChapterProbabilityInterface


open MeasureTheory

theorem BookProof.ChapterProbabilityInterface.transportMeasure_isProbability {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X)
    [IsProbabilityMeasure μ] : IsProbabilityMeasure (transportMeasure e μ) := by sorry
