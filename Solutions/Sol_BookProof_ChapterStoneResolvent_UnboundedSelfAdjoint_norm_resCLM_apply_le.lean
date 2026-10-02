-- Generated from ChapterStoneResolvent.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le
import Mathlib
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (T : UnboundedSelfAdjoint H)
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
 : H) : T.resCLM l y ∈ T.domain := (T.res l y).2

theorem solution (l : ℝ) ( := y : H) : ‖T.resCLM l
