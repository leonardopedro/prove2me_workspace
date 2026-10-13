-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.norm_prop_apply
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.QgTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) (t s : ℝ) (x : E) :
    ‖prop T t s x‖ = ‖x‖ := T.norm_stoneU_apply _ _
