-- Generated from ChapterTensorCompleteness.lean — theorem BookProof.ChapterTensorCompleteness.tensorOf_mem_pureTensors
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
import Definitions.Def_ChapterA4
open BookProof.ChapterTensorCompleteness

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]


noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor


theorem BookProof.ChapterTensorCompleteness.tensorOf_mem_pureTensors (u : Lp ℂ 2 μ) (v : Lp ℂ 2 ν) :
    tensorOf u v ∈ pureTensors μ ν := by sorry
