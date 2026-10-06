-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.omega_flow_apply
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.omega_flow_apply {A Om : E →L[ℂ] E} (h : Commute A Om) (t : ℝ) (x : E) :
    Om (flow A t x) = flow A t (Om x) := by sorry
