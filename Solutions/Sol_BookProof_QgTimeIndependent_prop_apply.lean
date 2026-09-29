-- Generated from ChapterQgTimeIndependentFlow.lean — solution of BookProof.QgTimeIndependent.prop_apply
import Mathlib
import Definitions.Def_ChapterQgTimeIndependentFlow
open BookProof.QgTimeIndependent









open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint E) (t s : ℝ) (x : E) :
    prop T t s x = T.stoneU (t - s) x := rfl
