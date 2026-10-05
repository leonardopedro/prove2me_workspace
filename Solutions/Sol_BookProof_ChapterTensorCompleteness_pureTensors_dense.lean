-- Generated from ChapterTensorCompleteness.lean — solution of BookProof.ChapterTensorCompleteness.pureTensors_dense
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
open BookProof.ChapterTensorCompleteness



noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((Submodule.span ℂ (pureTensors μ ν)) : Set (Lp ℂ 2 (μ.prod ν))) := by

  rw [Submodule.dense_iff_topologicalClosure_eq_top]
  exact tensorSpan_eq_top
