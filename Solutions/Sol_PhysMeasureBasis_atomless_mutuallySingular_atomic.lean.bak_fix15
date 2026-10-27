-- Generated from PhysMeasureBasis.lean — solution of PhysMeasureBasis.atomless_mutuallySingular_atomic
import Mathlib
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis



open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α]
    [MeasurableSingletonClass α] (μ ν : Measure α) [NullSingletonClass μ]
    {A : Set α} (hA : A.Countable) (hν : ν Aᶜ = 0) :
    μ ⟂ₘ ν := by

  refine ⟨A, ?_, ?_⟩
  · exact hA.measurableSet;
  · exact ⟨ hA.measure_zero μ, hν ⟩
