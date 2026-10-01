-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_apply_stoneU
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_add
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) (x : H) : T.stoneU s (T.stoneU t x) = T.stoneU (s + t) x := by

  rw [T.stoneU_add]; rfl
