-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transported_position_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transport_isSelfAdjointOn
import Theorems.Thm_BookProof_ChapterUnitaryTransport_mulOp_isSelfAdjointOn
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
ain f

theorem solution (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mul :=
  Op f)) :=
    transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjoi
