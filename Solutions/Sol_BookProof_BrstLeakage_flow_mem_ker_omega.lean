-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.flow_mem_ker_omega
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_omega_flow_apply
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {A Om : E →L[ℂ] E} (h : Commute A Om) (t : ℝ) {x : E}
    (hx : Om x = 0) : Om (flow A t x) = 0 := by

  rw [omega_flow_apply h t x, hx, map_zero]
