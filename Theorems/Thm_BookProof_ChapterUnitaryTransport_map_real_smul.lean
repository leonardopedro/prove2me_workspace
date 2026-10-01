-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.map_real_smul
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace



theorem BookProof.ChapterUnitaryTransport.map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by sorry
