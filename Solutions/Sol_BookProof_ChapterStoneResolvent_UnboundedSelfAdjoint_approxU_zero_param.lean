-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.approxU_zero_param
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_zero
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : T.approxU 0 t = 1 := by

  simp [approxU, yosidaGen]
