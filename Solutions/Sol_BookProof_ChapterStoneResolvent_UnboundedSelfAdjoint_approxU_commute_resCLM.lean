-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_commute_resCLM
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosidaGen_commute_resCLM
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n t l : ℝ) : Commute (T.approxU n t) (T.resCLM l) := (((T.yosidaGen_commute_resCLM n l).smul_left t)).exp_left
