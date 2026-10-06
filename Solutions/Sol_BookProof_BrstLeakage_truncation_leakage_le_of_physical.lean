-- Generated from ChapterBrstTruncationLeakage.lean — solution of BookProof.BrstLeakage.truncation_leakage_le_of_physical
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
import Theorems.Thm_BookProof_BrstLeakage_truncation_leakage_le
open BookProof.BrstLeakage



open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {P H Om : E →L[ℂ] E} (hPi : IsIdempotentElem P)
    (hPs : IsSelfAdjoint P) (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) (ht : 0 ≤ t) {x : E} (hx : P x = x) (hOm : Om x = 0) :
    ‖Om (flow (truncGen P H) t x)‖ ≤ ‖Om‖ * (‖(1 - P) * H * P‖ * ‖x‖ * t) := by

  simpa [hOm] using truncation_leakage_le hPi hPs hH hcomm t ht hx
