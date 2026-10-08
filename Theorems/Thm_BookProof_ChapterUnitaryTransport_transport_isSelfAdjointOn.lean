-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transport_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


theorem BookProof.ChapterUnitaryTransport.transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by sorry
