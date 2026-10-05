-- Generated from ChapterTensorCompleteness.lean — solution of BookProof.ChapterTensorCompleteness.exists_tensor_approx
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
import Theorems.Thm_BookProof_ChapterTensorCompleteness_pureTensors_dense
open BookProof.ChapterTensorCompleteness



noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]

set_option maxHeartbeats 1000000 in
theorem solution (v : Lp ℂ 2 (μ.prod ν)) {ε : ℝ} (hε : 0 < ε) :
    ∃ w ∈ Submodule.span ℂ (pureTensors μ ν), ‖v - w‖ < ε := by

  obtain ⟨w, hw, hlt⟩ := Metric.mem_closure_iff.mp
    ((pureTensors_dense (μ := μ) (ν := ν)) v) ε hε
  exact ⟨w, hw, by rwa [← dist_eq_norm]⟩
