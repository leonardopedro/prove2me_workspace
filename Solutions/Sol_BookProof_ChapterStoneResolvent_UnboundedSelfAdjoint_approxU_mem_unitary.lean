-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_mem_unitary
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_smul_yosidaGen_mem_skewAdjoint
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (n t : ℝ) : T.approxU n t ∈ unitary (H →L[ℂ] H) := exp_mem_unitary_of_mem_skewAdjoint (T.smul_yosidaGen_mem_skewAdjoint n t)
