-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_inner
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℝ) : IsSelfAdjoint (T.yosida n) := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr (fun y z => T.yosida_inner n y z)
