-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_commute
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_gen_commute
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n m s t : ℝ) : Commute (T.approxU n s) (T.approxU m t) := (((T.approxU_gen_commute n m).smul_left s).smul_right t).exp
