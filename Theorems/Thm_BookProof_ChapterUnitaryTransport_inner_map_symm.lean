-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.inner_map_symm
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


theorem BookProof.ChapterUnitaryTransport.inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by sorry
