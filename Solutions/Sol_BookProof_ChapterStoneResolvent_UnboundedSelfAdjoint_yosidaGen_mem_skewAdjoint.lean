-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosidaGen_mem_skewAdjoint
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_isSelfAdjoint
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℝ) : T.yosidaGen n ∈ skewAdjoint (H →L[ℂ] H) := by

  rw [skewAdjoint.mem_iff, yosidaGen, star_smul, (T.yosida_isSelfAdjoint n)]
  simp
