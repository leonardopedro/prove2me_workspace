-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.stoneU_mem_domain_two
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_op
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (x : T.domain) (hx : T.op x ∈ T.domain) :
    T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩ ∈ T.domain := by

  rw [T.stoneU_op t x]
  exact T.stoneU_mem_domain t ⟨T.op x, hx⟩
