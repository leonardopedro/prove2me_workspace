-- Generated from ChapterProbabilityInterface.lean — theorem BookProof.ChapterProbabilityInterface.transportMeasure_symm
import Mathlib
import Definitions.Def_ChapterProbabilityInterface
open BookProof.ChapterProbabilityInterface


open MeasureTheory

theorem BookProof.ChapterProbabilityInterface.transportMeasure_symm {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X) :
    transportMeasure e.symm (transportMeasure e μ) = μ := by sorry
