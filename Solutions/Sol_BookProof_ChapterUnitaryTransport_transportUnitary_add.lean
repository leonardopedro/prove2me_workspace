-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transportUnitary_add
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by

  simp [h]
