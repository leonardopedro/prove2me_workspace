-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.brst_leakage_bound_of_generator
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_apply
import Theorems.Thm_BookProof_BrstLeakage_omega_flow_apply
import Theorems.Thm_BookProof_BrstLeakage_norm_flow_sub_flow_le_cycle
import Theorems.Thm_BookProof_ChapterSirkRestart_brst_leakage_bound
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : IsSelfAdjoint B) (hcomm : Commute H Om) (tau : ℝ) (htau : 0 ≤ tau)
    (n : ℕ) (v : E) (hv : Om v = 0) :
    ‖Om (((flow B tau) ^ n) v)‖ ≤ ‖Om‖ * (n * (‖H - B‖ * tau) * ‖v‖) := by

  refine ChapterSirkRestart.brst_leakage_bound (flow H tau) (flow B tau) Om (‖H - B‖ * tau)
    (fun w => (norm_flow_apply hH tau w).le) (fun w => (norm_flow_apply hB tau w).le)
    (norm_flow_sub_flow_le_cycle hH hB tau htau) ?_ n v hv
  ext w
  simpa using omega_flow_apply hcomm tau w
