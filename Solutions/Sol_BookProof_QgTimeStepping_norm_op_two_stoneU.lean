-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_op_two_stoneU
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_stoneU_mem_domain_two
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_op




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (x : T.domain) (hx : T.op x ∈ T.domain) :
    ‖T.op ⟨T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩,
        stoneU_mem_domain_two T t x hx⟩‖
      = ‖T.op ⟨T.op x, hx⟩‖ := by

  set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
  have h1 : (⟨T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩,
      stoneU_mem_domain_two T t x hx⟩ : T.domain)
      = ⟨T.stoneU t ((x2 : H)), T.stoneU_mem_domain t x2⟩ := by
    apply Subtype.ext
    change T.op ⟨T.stoneU t (x : H), T.stoneU_mem_domain t x⟩ = T.stoneU t ((x2 : H))
    rw [T.stoneU_op t x]
  rw [h1, T.stoneU_op t x2, T.norm_stoneU_apply]
