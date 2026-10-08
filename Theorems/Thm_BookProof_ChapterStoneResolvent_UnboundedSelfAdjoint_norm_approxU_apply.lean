-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_apply
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (T : UnboundedSelfAdjoint H)

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_apply (n t : ℝ) (x : H) : ‖T.approxU n t x‖ = ‖x‖ := by sorry
