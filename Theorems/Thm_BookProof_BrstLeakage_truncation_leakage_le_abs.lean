-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.truncation_leakage_le_abs
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.truncation_leakage_le_abs {P H Om : E →L[ℂ] E} (hPi : IsIdempotentElem P)
    (hPs : IsSelfAdjoint P) (hH : IsSelfAdjoint H) (hcomm : Commute H Om)
    (t : ℝ) {x : E} (hx : P x = x) :
    ‖Om (flow (truncGen P H) t x)‖ ≤ ‖Om x‖ + ‖Om‖ * (‖(1 - P) * H * P‖ * ‖x‖ * |t|) := by sorry
