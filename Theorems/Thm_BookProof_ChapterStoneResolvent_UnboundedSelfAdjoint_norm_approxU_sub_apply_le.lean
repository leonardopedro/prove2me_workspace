-- Generated from ChapterStoneEvolution.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_apply_le
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Definitions.Def_ChapterStoneGroup
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent


open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (T : UnboundedSelfAdjoint H)

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_sub_apply_le (n m t : ℝ) (x : H) :
    ‖T.approxU n t x - T.approxU m t x‖ ≤ |t| * ‖T.yosida n x - T.yosida m x‖ := by sorry
