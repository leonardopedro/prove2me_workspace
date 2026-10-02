-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.map_real_smul
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by

  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]
