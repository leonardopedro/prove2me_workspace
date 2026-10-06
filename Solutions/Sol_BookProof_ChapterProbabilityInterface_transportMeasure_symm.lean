-- Generated from ChapterProbabilityInterface.lean — solution of BookProof.ChapterProbabilityInterface.transportMeasure_symm
import Mathlib
import Definitions.Def_ChapterProbabilityInterface
open BookProof.ChapterProbabilityInterface



open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X) :
    transportMeasure e.symm (transportMeasure e μ) = μ := by

  simp [transportMeasure]
