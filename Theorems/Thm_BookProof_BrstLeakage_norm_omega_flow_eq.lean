-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_omega_flow_eq
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.norm_omega_flow_eq {A Om : E →L[ℂ] E} (hA : IsSelfAdjoint A) (h : Commute A Om)
    (t : ℝ) (x : E) : ‖Om (flow A t x)‖ = ‖Om x‖ := by sorry
