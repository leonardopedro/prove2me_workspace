-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_apply_le
import Mathlib
import Definitions.Def_ChapterStoneEvolution
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_apply_le (n m t : ℝ) (x : H) :
    ‖T.approxU n t x - T.approxU m t x‖ ≤ |t| * ‖T.yosida n x - T.yosida m x‖ := by sorry
