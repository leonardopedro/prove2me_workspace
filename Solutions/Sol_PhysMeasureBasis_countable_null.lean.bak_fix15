-- Generated from PhysMeasureBasis.lean — solution of PhysMeasureBasis.countable_null
import Mathlib
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis



open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α]
    [MeasurableSingletonClass α] (μ : Measure α) [NullSingletonClass μ]
    {s : Set α} (hs : s.Countable) : μ s = 0 := by

  convert Set.Countable.measure_zero hs μ
