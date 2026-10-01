-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transportUnitary_zero
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by

  simp [h]
