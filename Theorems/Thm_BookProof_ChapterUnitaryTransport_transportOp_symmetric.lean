-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transportOp_symmetric
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

theorem BookProof.ChapterUnitaryTransport.transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by sorry
