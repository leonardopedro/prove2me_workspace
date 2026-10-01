-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.measurable_inner_stoneU
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_continuous_stoneU_apply
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (x y : H) :
    Measurable (fun t : ℝ => ⟪ y, T.stoneU t x ⟫_ℂ) := (continuous_const.inner (T.continuous_stoneU_apply x)).measurable
