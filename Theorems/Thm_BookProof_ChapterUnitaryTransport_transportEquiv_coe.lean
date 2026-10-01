-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transportEquiv_coe
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace



theorem BookProof.ChapterUnitaryTransport.transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := by sorry
