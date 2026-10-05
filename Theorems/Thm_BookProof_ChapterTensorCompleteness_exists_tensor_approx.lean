-- Generated from ChapterTensorCompleteness.lean — theorem BookProof.ChapterTensorCompleteness.exists_tensor_approx
import Definitions.Def_ChapterSolovayHilbertTensor
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
open BookProof.ChapterTensorCompleteness

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]


noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor


theorem BookProof.ChapterTensorCompleteness.exists_tensor_approx (v : Lp ℂ 2 (μ.prod ν)) {ε : ℝ} (hε : 0 < ε) :
    ∃ w ∈ Submodule.span ℂ (pureTensors μ ν), ‖v - w‖ < ε := by sorry
