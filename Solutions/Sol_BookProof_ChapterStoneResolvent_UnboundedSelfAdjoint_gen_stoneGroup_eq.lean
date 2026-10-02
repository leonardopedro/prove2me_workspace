-- Generated from ChapterStoneTheorem.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.gen_stoneGroup_eq
import Mathlib
import Definitions.Def_ChapterStoneTheorem
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_ext'
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_ext'
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_genOp_eq_op
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_genDomain_eq_domain
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable [TopologicalSpace.SeparableSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) : T.stoneGroup.gen = T := by

  refine ext' T.genDomain_eq_domain ?_
  intro x _ hx'
  exact T.genOp_eq_op ⟨x, hx'⟩
