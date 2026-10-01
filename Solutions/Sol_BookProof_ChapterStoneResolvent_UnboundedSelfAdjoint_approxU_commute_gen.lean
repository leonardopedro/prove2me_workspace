-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_commute_gen
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_gen_commute
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n m s : ℝ) : Commute (T.yosidaGen n) (T.approxU m s) := (((T.approxU_gen_commute n m).smul_right s)).exp_right
