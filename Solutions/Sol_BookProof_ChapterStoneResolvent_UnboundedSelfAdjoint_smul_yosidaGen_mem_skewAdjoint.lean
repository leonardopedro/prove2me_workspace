-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.smul_yosidaGen_mem_skewAdjoint
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosidaGen_mem_skewAdjoint
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n t : ℝ) :
    t • T.yosidaGen n ∈ skewAdjoint (H →L[ℂ] H) := by

  have h := T.yosidaGen_mem_skewAdjoint n
  rw [skewAdjoint.mem_iff] at h ⊢
  rw [star_smul, star_trivial, h, smul_neg]
