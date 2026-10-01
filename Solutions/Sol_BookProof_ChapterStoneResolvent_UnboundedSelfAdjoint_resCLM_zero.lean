-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.resCLM_zero
import Mathlib
import Definitions.Def_ChapterStoneGroup
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution : T.resCLM (0 : ℝ) = 0 := by

  ext y
  simp [resCLM, res]
