-- Generated from PhysMeasureBasis.lean — solution of PhysMeasureBasis.null_singleton
import Mathlib
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis



open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [MeasurableSingletonClass α] [NullSingletonClass μ] (a : α) : μ {a} = 0 := by

  convert MeasureTheory.NullSingletonClass.measure_singleton a;
  infer_instance
