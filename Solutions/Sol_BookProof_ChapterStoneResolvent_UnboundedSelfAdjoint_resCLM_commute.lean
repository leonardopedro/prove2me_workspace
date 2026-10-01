-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.resCLM_commute
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_resCLM_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_comm
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (l m : ℝ) : Commute (T.resCLM l) (T.resCLM m) := by

  rcases eq_or_ne l 0 with rfl | hl
  · simp [Commute, SemiconjBy]
  rcases eq_or_ne m 0 with rfl | hm
  · simp [Commute, SemiconjBy]
  ext y
  simpa using T.res_comm hl hm y
