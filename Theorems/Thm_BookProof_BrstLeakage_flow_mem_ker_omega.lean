-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.flow_mem_ker_omega
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open NormedSpace



theorem BookProof.BrstLeakage.flow_mem_ker_omega {A Om : E →L[ℂ] E} (h : Commute A Om) (t : ℝ) {x : E}
    (hx : Om x = 0) : Om (flow A t x) = 0 := by sorry
