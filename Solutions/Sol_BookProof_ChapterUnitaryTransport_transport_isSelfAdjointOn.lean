-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transport_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_coe_transportDomain
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transport_adjointDomain
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by

  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]
