-- Generated from ChapterStoneUnitary.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_stoneU_sub_approxU_le
import Mathlib
import Definitions.Def_ChapterStoneUnitary
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_stoneU_sub_approxU_le (k : ℝ) (t : ℝ) (x : T.domain) :
    ‖T.stoneU t (x : H) - T.approxU k t (x : H)‖ ≤ |t| * ‖T.op x - T.yosida k (x : H)‖ := by sorry
