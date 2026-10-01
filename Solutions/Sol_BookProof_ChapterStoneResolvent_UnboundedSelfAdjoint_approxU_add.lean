-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_add
import Mathlib
import Definitions.Def_ChapterStoneEvolution
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n s t : ℝ) : T.approxU n (s + t) = T.approxU n s * T.approxU n t := by

  rw [approxU, approxU, approxU, add_smul]
  exact exp_add_of_commute (((Commute.refl (T.yosidaGen n)).smul_left s).smul_right t)
