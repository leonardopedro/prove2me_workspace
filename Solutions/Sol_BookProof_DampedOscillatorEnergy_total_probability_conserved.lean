-- Generated from ChapterDampedOscillatorEnergy.lean — solution of BookProof.DampedOscillatorEnergy.total_probability_conserved
import Mathlib
import Definitions.Def_ChapterDampedOscillatorEnergy
open BookProof.DampedOscillatorEnergy




open MeasureTheory

set_option maxHeartbeats 1000000 in
theorem solution {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] {T : Ω → Ω} (hT : Measurable T) :
    (μ.map T) Set.univ = 1 := by

  rw [Measure.map_apply hT MeasurableSet.univ, Set.preimage_univ, measure_univ]
