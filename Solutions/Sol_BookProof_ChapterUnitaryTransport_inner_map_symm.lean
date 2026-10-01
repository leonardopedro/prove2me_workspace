-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.inner_map_symm
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by

  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _
