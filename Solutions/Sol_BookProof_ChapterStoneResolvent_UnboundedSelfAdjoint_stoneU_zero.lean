-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_zero
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_tendsto_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_zero
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution : T.stoneU 0 = 1 := by

  ext x
  refine tendsto_nhds_unique (T.tendsto_stoneU 0 x) ?_
  have h : (fun k : ℕ => T.approxU ((k : ℝ) + 1) 0 x) = fun _ : ℕ => x := by
    funext k; simp
  rw [h]
  simp
