-- Generated from ChapterStoneResolvent.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le
import Mathlib
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (T : UnboundedSelfAdjoint H)
variable [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

 : H) : T.resCLM l y ∈ T.domain := (T.res l y).2

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_resCLM_apply_le (l : ℝ) ( := by sorry
