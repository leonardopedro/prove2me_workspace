-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.coe_transportDomain
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


theorem BookProof.ChapterUnitaryTransport.coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := by sorry
