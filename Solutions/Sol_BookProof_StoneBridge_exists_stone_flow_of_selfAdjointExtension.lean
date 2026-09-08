-- Generated from ChapterStoneBridge.lean — solution of BookProof.StoneBridge.exists_stone_flow_of_selfAdjointExtension
import Mathlib
import Definitions.Def_ChapterStoneBridge
import Theorems.Thm_BookProof_StoneBridge_isStoneFlow_stoneU
open BookProof.StoneBridge







open Filter Topology
open scoped InnerProductSpace


open BookProof.FarisLavine BookProof.EsaClosure BookProof.YangMillsFriedrichs
open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]










variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (hdense : Dense ((D : Submodule ℂ F) : Set F))
    (h : IsSelfAdjointExtension Hc A) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)),
      T.domain = Dom ∧ HEq T.op A ∧ IsStoneFlow T U :=
  ⟨unboundedSelfAdjointOf hdense h, _, rfl, HEq.rfl,
      isStoneFlow_stoneU (unboundedSelfAdjointOf hdense h)⟩
