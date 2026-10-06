-- Generated from ChapterLinftyMultiplication.lean — solution of BookProof.ChapterLinftyMultiplication.memLp_top_one
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication



noncomputable section

open MeasureTheory ENNReal Complex


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution : MemLp (fun _ : α => (1 : ℂ)) ⊤ μ := memLp_top_const 1
