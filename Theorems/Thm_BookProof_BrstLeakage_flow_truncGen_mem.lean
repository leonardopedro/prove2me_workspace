-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.flow_truncGen_mem
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.flow_truncGen_mem {P H : E →L[ℂ] E} (hP : IsIdempotentElem P) (t : ℝ) {x : E}
    (hx : P x = x) : P (flow (truncGen P H) t x) = flow (truncGen P H) t x := by sorry
