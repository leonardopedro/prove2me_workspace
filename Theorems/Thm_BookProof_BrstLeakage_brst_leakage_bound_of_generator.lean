-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.brst_leakage_bound_of_generator
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.brst_leakage_bound_of_generator {H B Om : E →L[ℂ] E} (hH : IsSelfAdjoint H)
    (hB : IsSelfAdjoint B) (hcomm : Commute H Om) (tau : ℝ) (htau : 0 ≤ tau)
    (n : ℕ) (v : E) (hv : Om v = 0) :
    ‖Om (((flow B tau) ^ n) v)‖ ≤ ‖Om‖ * (n * (‖H - B‖ * tau) * ‖v‖) := by sorry
