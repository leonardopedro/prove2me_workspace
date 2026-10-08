-- Generated from ChapterBrstTruncationLeakage.lean — theorem BookProof.BrstLeakage.norm_unitary_apply
import Mathlib
import Definitions.Def_ChapterBrstTruncationLeakage
open BookProof.BrstLeakage


open NormedSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.BrstLeakage.norm_unitary_apply {U : E →L[ℂ] E} (hU : U ∈ unitary (E →L[ℂ] E)) (x : E) :
    ‖U x‖ = ‖x‖ := by sorry
