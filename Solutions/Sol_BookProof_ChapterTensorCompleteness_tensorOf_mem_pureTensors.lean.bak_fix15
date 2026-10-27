-- Generated from ChapterTensorCompleteness.lean — solution of BookProof.ChapterTensorCompleteness.tensorOf_mem_pureTensors
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
theorem solution (u : Lp ℂ 2 μ) (v : Lp ℂ 2 ν) :
    tensorOf u v ∈ pureTensors μ ν := ⟨_, _, Lp.memLp u, Lp.memLp v, rfl⟩
