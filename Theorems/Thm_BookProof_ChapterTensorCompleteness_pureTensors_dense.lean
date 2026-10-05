-- Generated from ChapterTensorCompleteness.lean — theorem BookProof.ChapterTensorCompleteness.pureTensors_dense
import Definitions.Def_ChapterSolovayHilbertTensor
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
open BookProof.ChapterTensorCompleteness

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]


noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor


theorem BookProof.ChapterTensorCompleteness.pureTensors_dense :
    Dense ((Submodule.span ℂ (pureTensors μ ν)) : Set (Lp ℂ 2 (μ.prod ν))) := by sorry
