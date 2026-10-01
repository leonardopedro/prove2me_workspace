-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transport_adjointDomain
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace



theorem BookProof.ChapterUnitaryTransport.transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by sorry
