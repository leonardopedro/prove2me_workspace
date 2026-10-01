-- Generated from ChapterStoneGenerator.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_mem_domain
import Mathlib
import Definitions.Def_ChapterStoneGenerator
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_commute_resCLM
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_resCLM_mem
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (x : T.domain) : T.stoneU t (x : H) ∈ T.domain := by

  have hx : ((T.res 1 (T.shift 1 x) : T.domain) : H) = (x : H) := by
    rw [T.res_shift one_ne_zero]
  have h : T.stoneU t (x : H) = T.resCLM 1 (T.stoneU t (T.shift 1 x)) := by
    rw [← T.stoneU_commute_resCLM]
    congr 1
    exact hx.symm
  rw [h]
  exact T.resCLM_mem 1 _
