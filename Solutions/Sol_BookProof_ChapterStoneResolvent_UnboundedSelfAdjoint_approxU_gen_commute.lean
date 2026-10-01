-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_gen_commute
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_commute
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n m : ℝ) : Commute (T.yosidaGen n) (T.yosidaGen m) := by

  unfold yosidaGen
  exact ((T.yosida_commute n m).smul_left _).smul_right _
