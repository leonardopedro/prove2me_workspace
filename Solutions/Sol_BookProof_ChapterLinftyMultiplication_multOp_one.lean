-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.multOp_one
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_memLp_top_one
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution : multOp (fun _ : α => (1 : ℂ)) memLp_top_one
    = ContinuousLinearMap.id ℂ (Lp ℂ 2 μ) := by

  refine ContinuousLinearMap.ext fun f => Lp.ext ?_
  filter_upwards [multOp_coeFn (fun _ : α => (1 : ℂ)) memLp_top_one f] with x h1
  simp [h1]
